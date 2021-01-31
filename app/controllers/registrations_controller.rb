# frozen_string_literal: true

class RegistrationsController < ApplicationController
  EMAIL_SUBJECT = '【お申し込み完了】イベントへのお申し込みありがとうございました'

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)
    return unless @registration.save

    body = { registration_id: @registration.id.to_s, email_subject: EMAIL_SUBJECT }.to_json
    region = 'ap-northeast-1'
    group_id = 'registration_email'
    sns_sender = AwsClients::SnsPublisher.new(region, Rails.application.credentials.sns_topic_arn, body, group_id)
    sns_sender.publish_message

    redirect_to registrations_complete_url
  end

  def complete; end

  private

  def registration_params
    params.require(:registration).permit(:first_name, :last_name, :email, :agreement)
  end
end
