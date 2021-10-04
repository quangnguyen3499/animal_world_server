class ApplicationWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform *_args
    raise NotImplementedError, "NotImplementedError"
  end
end
