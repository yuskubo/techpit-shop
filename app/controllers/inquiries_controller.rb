class InquiriesController < ApplicationController
  def new
    @inquire = Inquiry.new
  end

  def create
    @inquire = Inquiry.new(inquiry_params)
    if @inquire.save
      body = 'Inquiry EMail'
      attributes = { inquiry_id: { string_value: @inquire.id.to_s, data_type: 'Number' } }
      group_id = 'inquiry_email'
      sqs_register = AwsClients::SqsRegister.new('ap-northeast-1', Rails.application.credentials.queue_url, body, attributes, group_id)
      sqs_register.send_message

      redirect_to root_path
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:first_name, :last_name, :email, :agreement)
  end
end
