require 'sidekiq-scheduler'

class EmailSenderJob < ApplicationJob
  queue_as :default

  def self.run_batch
    Sidekiq::Batch.new.jobs do
      EmailSenderJob.set(wait: 10.seconds).perform_later('testです_3')
    end
  end


  def perform
    sqs_receiver = AwsClients::SqsReceiver.new('ap-northeast-1', Rails.application.credentials.queue_url, max_number: 10)
    response = sqs_receiver.receive_messages

    response.messages.each do |message|
      puts "Idは#{message.message_attributes['inquiry_id']['string_value']}"
    end

    sqs_receiver.delete_messages(response)
  end
end
