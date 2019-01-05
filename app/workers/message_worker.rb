class MessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(message_params)
    # TODO: Create validations to prevent worng data...
    Message.create(message_params)
  end
end
