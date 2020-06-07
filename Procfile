docker-compose: docker-compose -f docker/docker-compose_development.yml up
webpack-dev-server: bin/webpack-dev-server
sidekiq: bundle exec ruby -e "require 'redis'; sleep 5 until (Redis.current.ping rescue nil)" && bundle exec sidekiq