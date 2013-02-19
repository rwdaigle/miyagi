---
title: The Tortoise and The Octocat
date: December 11, 2012
authors:
  -
    name: Mattt Thompson
    site: http://mattt.me/
    profile:
      Mattt leads mobile development at Heroku, and waxes philosophical on matters of aesthetics, linguistics, & technique.
summary:
  "Programmers are the legislators, the authors, the arbiters of our digital existence. And in a world where the digital is increasingly inseparable from physical, the implication is clear: our decisions in code today affect our world tomorrow."
---

Software has social implications. Conversations about system architecture & design patterns, of standards & protocols: these are not merely academic exercises. Programmers are the legislators, the authors, the arbiters of our digital existence. And in a world where the digital is increasingly inseparable from physical, the implication is clear: our decisions in code today affect our world tomorrow.

## Revision Control

Consider the difference between [Git](http://git-scm.com) and [Subversion](http://subversion.apache.org). Although they both accomplish the task of [revision control](http://en.wikipedia.org/wiki/Revision_control), they go about it in completely different ways, and those differences are culturally significant.

Subversion is designed to have a central repository that clients synchronize with each time they want to commit a change. Git, on the other hand, uses a distributed architecture, in which there is no canonical repository and changes are synchronized by exchanging patches from peer to peer.

While this may seem like a minor architectural difference, the social implications are immense. Like that old [Chaos Theory](http://en.wikipedia.org/wiki/Chaos_theory) chestnut about a butterfly flapping its wings, even the slightest aspect can have a profound impact on the overall system (though it is difficult to anticipate or even understand these effects).

## Impact

Working with Subversion was slow, stressful, and frustrating. An Internet connection was required to get anything done, since the only way to commit -- even incremental changes to your working copy -- required synchronization with the server. Branching was cumbersome, and so committing directly to the trunk was not uncommon. But that had its own problems, whether that was a conflict from someone else's commit stopping you in your tracks, or the threat of your stashed changes breaking the production build somewhere down the line.

As a result of these small annoyances, teams using SVN often cultivated a culture of fear, intimidation, and isolation. Code became more difficult to write, which had a stifling effect on open source participation. Imagine the thousands of useful features went unwritten because of the cognitive and logistical overhead of collaboration with Subversion.

On the other hand, Git sparked a so-called "social coding" revolution. [GitHub](https://github.com) has transcended its utility of code storage to become the de facto social network for software developers. And as a result, the open source world has never been more connected. 

Git succeeded in a way that Subversion never could, and it has everything to do with its architecture.

## Decentralization

As a decentralized system, there are few constraints on how code is be managed. Rather than there being a canonical source of truth, each repository tells its own story, with alternative histories that can be joined up later with others by massaging out the details. (But they don't have to.)

One of the most interesting consequences of being decentralized is that developers are forced to communicate amongst themselves to negotiate how they work together. Pull Requests form the atomic unit of collaboration, as well as a forum in which teams can discuss the shape and direction of their work. "Pull Requests Welcome" has become a universal slogan that invites everyone to contribute however they can.

Greater participation means better software, which, in turn, has deep implications on the kinds of relationships and institutions that fill our lives.

This is not at all to say that Subversion is all bad and Git is all good. SVN was a massive improvement over CVS, which itself revolutionized software development as the first popular client-server version control system. And Git... well, surely there are some things Git could do better, and there are new paradigms we've only yet to discover.

## Software as Culture

Revision control is but one example of our decisions as developers affecting more than our code. Consider the organizational implications of embracing open-source libraries vs. a proprietary application stack. Or of developing on Unix versus Windows. Or of using Ruby vs. Java.

One choice is not strictly better than any other, but they are indeed _cultural_ choices.

It's not often that we think about the social implications of choosing or development tools or application technologies. Perhaps it's time we started. The decisions we make in our text editors can fundamentally change our relationship with the people and world around us.