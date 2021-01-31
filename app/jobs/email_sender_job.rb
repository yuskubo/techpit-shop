# frozen_string_literal: true

class EmailSenderJob < ApplicationJob
  queue_as :default

  def perform
    response = sqs_receiver.receive_messages
    response.messages.each do |message|
      parsed_body = JSON.parse(message.body)
      parsed_message = JSON.parse(parsed_body['Message'])
      registration = Registration.find_by(id: parsed_message['registration_id'])
      RegistrationMailer.registration(registration, parsed_message['email_subject']).deliver_now
    end

    sqs_receiver.delete_messages(response)
  end

  private

  def sqs_receiver
    @sqs_receiver ||= AwsClients::SqsReceiver.new('ap-northeast-1', Rails.application.credentials.queue_url, max_number: 10)
  end
end
