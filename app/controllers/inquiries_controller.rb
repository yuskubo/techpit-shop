# frozen_string_literal: true

class InquiriesController < ApplicationController
  def new
    @inquire = Inquiry.new
  end

  def create
    @inquire = Inquiry.new(inquiry_params)
    return unless @inquire.save

    body = { inquiry_id: @inquire.id.to_s, email_subject: '無料体験レッスンの日程のお知らせ' }.to_json
    region = 'ap-northeast-1'
    group_id = 'inquiry_email'
    sns_sender = AwsClients::SnsPublisher.new(region, Rails.application.credentials.sns_topic_arn, body, group_id)
    sns_sender.publish_message

    redirect_to inquiries_complete_url(hoge: 'test')
  end

  def complete; end

  private

  def inquiry_params
    params.require(:inquiry).permit(:first_name, :last_name, :email, :agreement)
  end
end
