# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


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

Rate limit of unsplash API(demo) is very low.
So it's convenient to use VCR for development.
(VCR records API response and caches to file)

To use VCR, just set `ENABLE_VCR=1` on ENV.

```
% ENABLE_VCR=1 rails s
```

details, see `config/initializer/vcr.rb` and `ExternalApiRecordAndMockable` concerns module