max_threads_count = ENV.fetch("RAILS_MAX_THREADS") {5}
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") {max_threads_count}
threads min_threads_count, max_threads_count
port ENV.fetch("PORT") {3000}
environment ENV.fetch("RAILS_ENV") {"development"}
if ["staging", "production"].include?(ENV.fetch("RAILS_ENV"))
  workers ENV.fetch("WEB_CONCURRENCY") { 2 }
end
preload_app!
###
before_fork do 
  @sidekiq_pid ||= spawn('bundle exec sidekiq -C config/sidekiq.yml')
end
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
on_restart do
  Sidekiq.redis.shutdown { |conn| conn.close }
end
pidfile ENV.fetch("PIDFILE") {"tmp/pids/server.pid"}
plugin :tmp_restart
