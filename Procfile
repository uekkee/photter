docker-compose: docker-compose -f docker/docker-compose_development.yml up
webpack-dev-server: bin/webpack-dev-server
sidekiq: bundle exec ruby -e "require 'redis-client'; sleep 5 until (RedisClient.new.call('PING') rescue nil)" && bundle exec sidekiq
