<p align="center">
  <img src="http://f.cl.ly/items/3s0x2t3f0D2L0O0p0H04/Image%202013-01-11%20at%202.43.19%20PM.png" />
</p> 

# Miyagi

Miyagi is a Heroku-inspired journal of application development. It is meant to serve as an educational tool for developers wishing to stay at the edge of their craft and as an outlet for practitioners to give others insight into their techniques.

Miyagi is open to all contributors that wish to speak to a diverse audience of technologists.

## Running locally

Miyagi uses [Middleman](http://middlemanapp.com/), a Ruby-based static site generator, to render the site in development mode. Get Miyagi running locally with the following steps:

1. `git clone git://github.com/rwdaigle/miyagi.git && cd miyagi`
2. `bundle install`
3. `middleman`
4. open `http://localhost:4567`

Miyagi uses the livereload mechanism during development to automatically reload the site when a file changes. This makes writing in Markdown alongside the real-time rendered article a reality.

## Contributing

We welcome contributors across disciplines - web dev, Ruby, Clojure, Go, Javascript, front-end, mobile etc... If you have an interest in promoting a particular technique, perspective or vision please get in touch with `rd at heroku.com`.

Once you are comfortable that your topic is appropriate for Miyagi contributing is as easy as forking this repo and creating a new markdown file in the `articles` directory. Copy the frontmatter from an existing article to get started.

Miyagi supports Github flavored markdown so you can use other tools such as [Gists](https://gist.github.com/) during the writing phase before merging into Miyagi.

### I have an idea, but no time

Miyagi's main purpose is to free the thoughts that are so often locked within developers' heads. One observation from working with technical content in a variety of roles is that the hardest part is often the structuring of the idea and the putting it on paper. To remove those bottlenecks we're experimenting with performing short interviews from which a ghost-writer will write the article for you. Please let us know if you'd like to explore this approach: `rd at heroku.com`.

## Deployment

Though it is a static site, Miyagi runs on Heroku and utilizes the [multi-buildpack](http://github.com/ddollar/heroku-buildpack-multi) to chain the [middleman buildpack](http://github.com/meskyanichi/heroku-buildpack-middleman) and [nginx buildpack](http://github.com/essh/heroku-buildpack-nginx). This allows site generation to occur when you do a `git push heroku master` and serves the content via the very fast nginx.

To deploy your own Miyagi:

1. `git clone git://github.com/rwdaigle/miyagi.git && cd miyagi`
2. `heroku create --buildpack git://github.com/ddollar/heroku-buildpack-multi.git`
3. `heroku config:set HOST=mysite.com`
3. `git push heroku master`
4. `heroku open`