# Photter 

[![ruby](https://github.com/uekkee/photter/workflows/ruby/badge.svg)](https://github.com/uekkee/photter/actions)
[![Jest](https://github.com/uekkee/photter/workflows/Jest/badge.svg)](https://github.com/uekkee/photter/actions)
[![pronto](https://github.com/uekkee/photter/workflows/Pronto/badge.svg)](https://github.com/uekkee/photter/actions)

[![Photter demo](http://img.youtube.com/vi/NYZpJHSPhPU/0.jpg)](http://www.youtube.com/watch?v=NYZpJHSPhPU "Photter demo")

You can see the DEMO MOVIE by clicking image above!

## What's Photter?

- Search images via [Unsplash](https://unsplash.com/) API
- Save image urls to local DB with Tags
- Download image urls CSV with Tag
 
## System overview

- Required languages and Packaging frameworks
  - Ruby: 3.0.2+
  - Bundler: 2.1.4  
  - Node: 12.x
  - yarn: 1.22.4+

- System dependencies
  - Docker (Every middlewares run with docker-compose!)
  - Mysql 8
  - Redis 6.0

## How to set up

- Configuration
  - bundle install
  - yarn install
  - Unsplash API settings (see below)

- Running required processes
  - foreman start
    - runs mysql and redis via docker-compose
    - runs webpack-dev-server
    - runs sidekiq

- Database creation
  - rails db:create

- Database initialization
  - rails db:migrate

- How to run the test suite
  - rspec


## Unsplash API settings

### 1. create unsplash API key

You need to create Unsplash API keys.
see more details: https://unsplash.com/developers

### 2. set API keys to the app credentials

just add credentials  

```
% rails credentials:edit -e development
```

```:yaml
unsplash:
  access_key: #{your unsplash access key}
  secret_key: #{secret key also}
```

### [optional] enable VCR on development

Rate limit of unsplash API(demo) is [VERY LOW](https://unsplash.com/documentation#rate-limiting).
So it's convenient to use VCR for development.
(VCR records API response and caches to file)

To use VCR, just set `ENABLE_VCR=1` on ENV.

```
% ENABLE_VCR=1 rails s
```

details, see `config/initializer/vcr.rb` and `ExternalApiRecordAndMockable` concerns module
