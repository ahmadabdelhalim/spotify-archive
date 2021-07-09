class ArchiverWorker
  include Sidekiq::Worker

  def perform(user_id)
    Archiver.run(user_id)
  end
end
