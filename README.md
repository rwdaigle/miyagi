# The Application Development Journal

## Local setup

1. Clone repo
2. `cp .env.sample .env`. Edit `DATABASE_URL` value.
4. `rake db:migrate data:staging`
3. `gem install foreman`
4. `foreman start`
5. open `localhost:5000`