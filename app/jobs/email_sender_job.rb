# frozen_string_literal: true

class EmailSenderJob < ApplicationJob
  queue_as :default

  def perform
    response = sqs_receiver.receive_messages
    response.messages.each do |message|
      parsed_body = JSON.parse(message.body)
      parsed_message = JSON.parse(parsed_body['Message'])
      inquirer = Inquiry.find_by(id: parsed_message['inquiry_id'])
      InquiryMailer.inquiry(inquirer, parsed_message['email_subject']).deliver_now
    end

    sqs_receiver.delete_messages(response)
  end

  private

  def sqs_receiver
    @sqs_receiver ||= AwsClients::SqsReceiver.new('ap-northeast-1', Rails.application.credentials.queue_url, max_number: 10)
  end
end
