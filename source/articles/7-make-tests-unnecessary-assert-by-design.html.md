---
title: "Make Tests Unnecessary: Assert by Design"
date: December 5, 2012
author:
  name: Pedro Belo
  site: http://pedro.herokuapp.com/
  profile:
    Pedro is a proponent of shipping, improving and avoiding code. Current obsessions include: APIs, distributed architectures, zero downtime deploys and <a href="http://en.wikipedia.org/wiki/Caipirinha">caipirinhas</a>.
summary:
  Automated testing is a proven tool for verifying application behavior and preventing bugs and regressions. However, as a last-minute line of defense, testing can often be eschewed in favor of baking preventative behavior directly into the application design.
---

Sometimes tests are not the best tool to assert that code behaves the way it was intended to.

Take SQL injection, for instance: When was the last time you wrote a test to make sure your web app is protected? Maybe back in the day when writing our own SQL layer wasn't a complete idiotic idea. Or maybe last time Paul introduced a hole and you had to write a regression test because you just don't trust the guy.

Either way, the fact is that we just don't see any TDD enthusiast writing a SQL injection test before establishing a connection.

"Well,” they say, "my framework provides the protection. I should not be testing third party code!”

What about the authentication system, then? Should we write integration tests for every single endpoint in the application, making sure they are applying the right access control rules? What about audit traces, metrics logging, page caching?

Nick Kallen says "[the biggest danger with Access Control rules is the possibility that a careless Programmer might forget to implement them](http://pivotallabs.com/users/nick/blog/articles/272-access-control-permissions-in-rails)”. Even with nice helpers, patterns for testing, and 100% coverage a careless programmer can still compromise your security, and there's nothing we can do about this.

Or is there?

I feel pretty confident that my code is protected against SQL injection, despite not having a single test on this front. And the reason is simple: modern web applications are protected against most security vulnerabilities by design. Create a vanilla Rails application and you'll have to go out of your way to introduce vulnerabilities. Modern ORMs don't just provide security, they enforce it in their contract.

There's nothing preventing us from getting the same kind of reassurance on other day-to-day issues: Design an authentication mechanism where it's impossible to allow access without implementing a rule; introduce a pattern so users can't perform actions without leaving an audit trace; consider open sourcing your design, when other programmers are clients you start thinking about design and contracts from another perspective.

Well designed code will never substitute testing, but does give you the reassurance that no code coverage can match.

Don't test for the proper development practices, codify them.