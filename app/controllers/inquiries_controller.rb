class InquiriesController < ApplicationController
  def new
    @inquire = Inquiry.new
  end

  def create
    @inquire = Inquiry.new(inquiry_params)
    if @inquire.save
      body = 'Inquiry EMail'
      attributes = {
        'inquiry_id' => {
          string_value: @inquire.id.to_s,
          data_type: 'Number'
        }
      }
      sqs_register = AwsClients::SqsRegister.new('ap-northeast-1', Rails.application.credentials.queue_url, body, attributes)

      begin
        sqs_register.send_message
      rescue Aws::SQS::Errors::ServiceError
        puts "エラーが発生し、inquire_id：#{@inquire.id}のキューが登録されませんでした"
      end

      redirect_to root_path
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :agreement)
  end
end
