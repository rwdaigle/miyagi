# The Application Development Journal

## Local setup

```bash
bundle
cp config/database.yml.example config/database.yml
rake data:staging:reset
foreman start
```
Open [localhost:5000](http://localhost:5000).

Once in development, the seed data can be refreshed (deleted and reinstated from db:seed) with `rake data:refresh`.