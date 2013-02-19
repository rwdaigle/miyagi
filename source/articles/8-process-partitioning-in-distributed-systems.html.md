---
title: Process Partitioning in Distributed Systems
date: December 6, 2012
authors:
  -
    name: Ryan Smith
    site: http://ryandotsmith.heroku.com/
    profile:
      Ryan builds distributed systems at <a href="http://heroku.com">Heroku</a>. His writing is motivated by many successes and failures experienced with production systems at Heroku.
summary:
  Assigning a group of worker processes to operate, in parallel, against a large dataset is a very efficient approach to data processing. Process partitioning is a scalable approach for coordinating work across a pool of independent workers.
---

## The problem

When working with large, high volume, low latency systems, it is often the case that processing data sequentially becomes detrimental to the system's health. If we only allow 1 process to work on our data we run into several challenges:

* Our process may fall behind resulting in a situation which it is impossible for our process to catch up.
* Our singleton process could crash and leave our system in a degraded state.
* The average latency of data processing could be dramatically affected by outlying cases.

For these reasons, we wish to design a system which allows N number of processes to work on a single data set. In order to arrive at a possible solution, let me outline some assumptions of the system.

* A data store exists, containing items to be processed.
* The data store supports atomic updates or conditional puts.
* The system runs on a horizontally scalable platform that contains homogenous environment variables.

## Solution

There are multiple approaches to processing data in parallel. By way of comparison let's compare process partitioning with queuing, the most common solution to data processing.

### Queuing

Queuing decouples data-processing workers from other system components and is a broadly accepted solution to processing data in parallel. However, there are certain scenarios where process partitioning is a better solution.

Consider the case when your dataset lends itself to partitioning - in that the data has keys which are broadly spread across a wide value range. A partitioning scheme for such data can be created with minimal effort and allows us to keep the data-processing close to the data model itself. Another data abstraction, that of a queue, isn't necessary in this case.

Using queues also exposes you to the noisy-neighbor syndrome. If you have 25 jobs on the queue, all consisting of the same resource-intensive work, your queue could get bogged down while less intensive processing is blocked. Queues represent a false form of parallelism and are subject to such congestion.

Queues may also not be appropriate when you have a high number of worker processes. Many workers accessing the same resource (the queue) can create a high contention rate. This threshold varies considerably considering the queue and langue being used, but be conscious of this limitation as your worker pool approaches 100 processes.

In such cases process partitioning offers a less contentious way to access your data without requiring additional abstractions.

### Process partitioning

Process partitioning approaches parallelism from a different angle. It creates logical shards of the dataset and assigns a single independent process to that subset of data. Since the data they access is unique to their process they're not contending for a single resource and can more predictably scale to large numbers of processors.

You could achieve similar benefit by using N queues (one per processor). However, an additional queue needs to be provisioned every time you want to increase the worker pool and you're still left with an additional component to manage. In many cases process partitioning is an ideal solution.

Our approach to process partitioning involves distributing the workload over N processors. Each processor will coordinate with a centralized data store to obtain an integer based identity. Thus each process will be identified by an integer from 0 to N. The processor will use it's identity to exclusively find work. We will assign each item of work an integer value and the processor will select the item of work if the item's value modulo N is equal to the processor's id. Let us explore the details of our approach.

## Identity coordination

Each processor should have access to N -- which is the maximum number of processors. N can be an environment variable defined in each processor's memory. Upon initialization, each processor will successively choose a number from 0 to N until the processor can globally lock it's identity. To lock an identity, each processor must request a lock on the identity with a central data store. The following code snippet is an example of identity coordination in Ruby:

```ruby
def acquire_lock
  ENV["N"].to_i.times do |i|
    Locksmith::Dynamodb.lock("my-process-#{i}") do
      yield(i) #critical section
    end
  end
end
```

Tools such as [lock-smith](https://github.com/ryandotsmith/lock-smith) and [ddbsync](https://github.com/ryandotsmith/ddbsync) provide a convenient way to acquire a global lock as does native data store functionality such as Postgres' [pg_advisory_lock](http://www.postgresql.org/docs/9.1/static/functions-admin.html#FUNCTIONS-ADVISORY-LOCKS) and MySQL's [GET_LOCK](http://dev.mysql.com/doc/refman/5.5/en/miscellaneous-functions.html#function_get-lock).

## Work item selection

Selecting data for each processor to process will be determined by the data store containing the items to be processed. Data stores supporting predicate analysis (e.g. SQL) will allow the processor to submit a query for data based on our modulo predicate. Data stores like Dynamodb will require the processor to scan data into memory and apply the predicates locally. You should take your data's size into consideration when choosing the store for your items to be processed. Scanning the table into memory may not be feasible. An example of both approaches in Ruby:

#### SQL

```ruby
acquire_lock do |partition|
  sql = "select * from items_to_be_processed where MOD(id, ?) = ?"
  DB.exec(sql, Integer(ENV["N"]), partition)
end
```

#### In-memory scan

```ruby
acquire_lock do |partition|
  DB.scan.select do |item|
    item.id % Integer(ENV["N"]) == partition
  end
end
```

#### Non-integer identities

One caveat with the previous examples... It may not always be possible to have an integer based identity on your items-to-be-processed. In these cases we can use the CRC-32 algorithm to produce an checksum of the bytes of data and use the checksum in our modulo computation.

```ruby
acquire_lock do |partition|
  DB.scan.select do |item|
    Zlib.crc32(item.id) % Integer(ENV["N"]) == partition
  end
end
```

## Fault tolerance

In order to address the problem of maximizing the availability of our processors, we need only keep redundant processor online. If a processor should fail, it's lock will be released allowing a redundant processor to acquire the lock in the identity coordination phase. For critical systems, keeping 2*N processors should be sufficient.

## Conclusion

Process partitioning provides a way to process great amounts of data in parallel. It offers a simple design that can be implemented in any language on a variety of data stores. This approach is a great alternative to commonly seen queue based approaches. In fact, there are many cases in which this approach provides a greater level of concurrency which will allow a more robust data processing system. The proof of the concurrency improvements will be an exercise left to the reader.