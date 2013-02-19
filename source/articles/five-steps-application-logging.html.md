---
title: 5 Steps to Better Application Logging
date: February 19, 2013
authors:
  -
    name: Ryan Daigle
    site: https://twitter.com/rwdaigle
    gplus: https://plus.google.com/u/0/106431285901024293656
    profile:
      Ryan works at Heroku where he attempts to expose progressive cultural and technology practices through journalism.
  -
    name: Troy Davis
    site: https://twitter.com/troyd
    profile:
      Troy is the founder of the hosted log management service, <a href="https://papertrailapp.com/">Papertrail</a>, and has seen the log usage of thousands of customers.
summary:
  "Logs are a source of time-ordered events about everything happening with your app. But their inconsistent verbosity and substance obscures the big-picture view. What if you could easily and automatically roll them up into daily charts, or run ad-hoc queries to look for correlations on user behavior?"
---

Logs are a source of time-ordered events about everything happening with your app. But their inconsistent verbosity and substance obscures the big-picture view. What if you could easily and automatically roll them up into daily charts, or run ad-hoc queries to look for correlations on user behavior?

![Librato charts from log data](https://dl.dropbox.com/u/674401/miyagi/librato-graphed-logs.png)

Then we see that logs are far more than ephemeral output or a simple debugging aid. Logs are data that provide incredible operational and business visibility.

## The possibilities

A well-structured, relevant, event stream lays the foundation for higher levels of abstraction, aggregation and visualization. Consider the following uses for your log data:

* Use a service like [Papertrail](https://papertrailapp.com/) to search logs, issue alerts when certain conditions are met, and put logs on S3 to mine with an [Elastic Map Reduce](http://aws.amazon.com/elasticmapreduce/) job. ![](https://dl.dropbox.com/u/674401/miyagi/papertrail-search.png)
* Piping logs of a known format to your own [metrics analysis service](https://github.com/ryandotsmith/l2met) to calculate time-based statistical averages which are then sent to [Librato](https://metrics.librato.com/) for visualization on a team dashboard.
* Provision [Splunk Storm](https://www.splunkstorm.com/) to perform machine data analysis and detect anomalies in system behavior. ![](https://dl.dropbox.com/u/674401/miyagi/splunk-graphs.png)
* Running your own [log drain app](https://github.com/rwdaigle/heroku-log-store) to perform custom actions on your log stream.

In their default form, it's not likely that your application logs can power services such as these or give you meaningful insight. Here are 5 steps to change that.

## Choose core set of events

Logs are not excreted by your application. They are deliberately created by you, the developer, to provide insight. Don't obfuscate this channel by logging everything you can access. Instead, reduce your logs to their essence by sequestering log data along two axes: operational events and business events.

Operational data indicates the general health and performance of your application. What are the three most crucial metrics for knowing if your application is functioning properly? Include these measurements, such as response times, requests per second and queue length, in your log stream.

The other log axis, business data, relates to your application’s efficacy in serving the business and its users. Apply the same exercise: Choose the three questions you must answer to know if your application is serving your business. Keep the vocabulary at the user level to prevent regressions to the operational aspects of the app.

By way of example, a log management business like [Papertrail](https://papertrailapp.com/) must, authoritatively, know:

* Is log processing behind?
* How far behind is the processing queue?
* How many customers are affected?

Focus on your operational and business needs to identify a small set of metrics. From this initial dataset you can expose the metrics that are of unique value to you and your business.

## Configure log output

Application logs [should be streamed](http://12factor.net/logs), unbuffered, to `STDOUT` and not stored in files on the local system. These event streams, when piped to other services, can be collated across sources into a single, sequential system-wide view. Determine the necessary settings for your language, framework or library to output logs to `STDOUT`.

In such streamed environments, contain logical messages to a single line to avoid interspersion with other time-ordered messages. Consider two simultaneous requests to a Rails app running on two compute instances that are interleaved to a single output:

```
Processing PostsController#create (for 127.0.0.1 at 2008-09-08 11:52:54) [POST]
 Session ID: BAh7BzoMY3NyZl9pZCI...
Processing PostsController#update (for 127.0.0.1 at 2008-09-08 11:52:54) [PUT]
 Session ID: BuHFc0kh2J…
 Parameters: {"post"=>{"title"=>"Logging Rails"...
 Parameters: {"post"=>{"title"=>"Debugging Rails"...
Completed in 0.01224 (81 reqs/sec) | DB: 0.00044 (3%) | 302 Found [http://localhost/posts]
Completed in 0.11224 (9 reqs/sec) | DB: 0.00021 (1%) | 302 Found [http://localhost/posts]
```

From this unified output it's impossible to know what data belongs to which request. When logical log statements aren't contained in a single line their atomicity can't be guaranteed. 

Condense the default log output for your framework by adjusting the logger configuration or using a library like Rails' [lograge](https://github.com/roidrage/lograge):

```
method=POST path=/posts format=html controller=posts action=create status=302 duration=0.01224 view=0.01201 db=0.00044
method=PUT path=/posts format=html controller=posts action=update status=302 duration=0.11224 view=0.11201 db=0.00021
```

Streaming single-line logs to `STDOUT` ensures a logical and unified view of your system’s events.

## Use a structured format

Historically, logs have been targeted for human eyes. But logs can serve more than one master. Log management software (see: [Fluentd](http://fluentd.org/) and [Scribe](https://github.com/facebook/scribe)) and services (see: [Papertrail](https://papertrailapp.com/) and [Splunk](http://www.splunk.com/view/splunk-storm/SP-CAAAG58)) receive log streams for higher order processing and analysis and can be attached to most modern platforms like [Heroku](https://devcenter.heroku.com/articles/logging#syslog-drains) or any infrastructure with access to [syslog-ng](http://www.balabit.com/network-security/syslog-ng/opensource-logging-system).

Human readability and machine parsability are not mutually exclusive concerns. Serve both by choosing a structured log format that contains as little decoration as possible. A simple `key=value` format works well for its easy command line scriptability and token extraction. Also, its implementation is trivial and independent of the implementation language:

```java
logger.info("measure=papertrail.queue.backlog val=" + queueBacklog);
```

Target both humans and machines when creating your log statements with a simple, structured format. This ensures the logs' viability and longevity.

## Use consistent log keys

[Naming is hard](http://martinfowler.com/bliki/TwoHardThings.html). This is true of many things, including log keys. Using name-spaced keys within a consistent key-set simplifies the instrumentation of logs and enables tools that consume these logs.

Consider the following core keys for your log data:

<table>
  <tr>
    <th>Key</th>
    <th>Meaning</th>
    <th>Example</th>
  </tr>
  <tr>
    <td><code>measure</code></td>
    <td>the name-spaced label of the data-point</td>
    <td>
      <code>measure=app.session-controller.login</code>
      <code>measure=app.queue.backlog</code>
    </td>
  </tr>
  <tr>
    <td><code>val</code></td>
    <td>the optional data-point value (omit for single occurrence counts)</td>
    <td><code>val=1.23</code></td>
  </tr>
  <tr>
    <td><code>units</code></td>
    <td>optional units if <code>val</code> is ambiguous</td>
    <td><code>units=ms</code></td>
  </tr>
</table>

Using these conventions clearly identifies the primary measurement of each log statement and establishes a known key-set that other tools can interrogate.

Logs using this convention can be piped to a service like [l2met](https://github.com/ryandotsmith/l2met) which will calculate a set of time-based functions on the data and send it to Librato for visualization.

## Include contextual data

This is not to say that log data is limited to this key-set. Related and relevant event information should be included to support querying, simple reporting and historical analysis.

Include the directly participating entities for context and namespace them appropriately (`user-` and `article-`) to enforce consistency across logs. When logging its article publishing activity the [Heroku Dev Center](https://devcenter.heroku.com/) includes the following data:

```
measure=devcenter.article.edit user-id=31 user-email=editor@heroku.com article-id=49 article-title="Dynos and the Dyno Manifold"
```

Strike a balance between machine and human readability by including both uniquely identifiable machine ids (`user-id`, `article-id`) and human ids (`editor@heroku.com` and `Dynos and the Dyno Manifold`).

Also consider the inclusion of a session or request id on every log statement to make it easier to identify the path of specific entities. This key should represent as long of an unbroken session as you can identify while still offering enough granularity to be useful as a debugging tool.

A simple implementation could be the pairing of values that are unlikely to change, such as the user's system id/username, with a more time-constrained value like the current date.

Logging libraries like [Scrolls](https://github.com/asenchi/scrolls) allow you to set contexts, which are ideal for session keys.

```ruby
def around_request
  session_key = Digest::MD5.hexdigest(user.id.to_s + Date.today)
  Scrolls.context(session: session_key) do
    yield
  end
end
```

This key is then output as part of every log statement within the context and allows you to filter logs based on a single, known, entity.

```
session=e59ff902d260 measure=app.search.execution val=20.4 units=ms
session=e59ff902d260 measure=app.pref.toggle val=true preference=emails
```

Logs data is unique to every application. However, be disciplined in your logging by including a minimal but consistent set of supporting information.

## Conclusion

Logs are a loosely coupled source of rich application data. Leverage this datasource with a purposeful approach to logging and gain deep insight into your app's performance profile and user-behavior. Experiment with logging and log-management services to find the right level of visibility for your needs.