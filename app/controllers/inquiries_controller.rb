class InquiriesController < ApplicationController
  def new
    @inquire = Inquiry.new
  end

  def create
    @inquire = Inquiry.new(inquiry_params)
    if @inquire.save
      body = 'Inquiry EMail'
      attributes = {
        inquiry_id: { string_value: @inquire.id.to_s, data_type: 'Number' },
        email_subject: { string_value: '無料体験レッスンの日程のお知らせ', data_type: 'String' }
      }
      group_id = 'inquiry_email'
      sqs_sender = AwsClients::SqsSender.new('ap-northeast-1', Rails.application.credentials.queue_url, body, attributes, group_id)
      sqs_sender.send_message

      redirect_to inquiries_complete_url
    end
  end

  def complete
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:first_name, :last_name, :email, :agreement)
  end
end
