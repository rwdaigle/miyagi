# Miyagi

http://miyagi.herokuapp.com/ An open journal on the technique of application development

## Local setup

```bash
$ bundle
$ cp config/database.yml.example config/database.yml
$ rake db:setup
$ foreman start
```

Open [localhost:5000](http://localhost:5000).

Once in development, the seed data can be refreshed (deleted and reinstated from db:seed) with `rake data:refresh`.

## Icon Font Generation

```bash
$ brew install fontforge eot-utils ttfautohint
$ rake font
```

## Deploying to Heroku

```bash
$ heroku create
$ git push heroku master
$ heroku run "rake db:migrate data:refresh"
```