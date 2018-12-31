class MessageWorker
  include Sidekiq::Worker

  def perform(message_params)
    # TODO create validations to prevent worng data...
    Message.create(message_params)
  end
end
