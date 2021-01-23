require 'sidekiq-scheduler'

class EmailSenderJob < ApplicationJob
  queue_as :default

  def perform
    sqs_receiver = AwsClients::SqsReceiver.new('ap-northeast-1', Rails.application.credentials.queue_url, max_number: 10)
    response = sqs_receiver.receive_messages

    response.messages.each do |message|
      inquirer = Inquiry.find_by(id: message.message_attributes['inquiry_id']['string_value'])
      InquiryMailer.inquiry(inquirer, message.message_attributes['email_subject']['string_value']).deliver_now
    end

    sqs_receiver.delete_messages(response)
  end
end
