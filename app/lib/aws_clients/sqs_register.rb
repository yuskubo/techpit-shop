module AwsClients
  class SqsRegister
    def initialize(region, queue_url, body, attributes)
      @sqs = Aws::SQS::Client.new(region: region)
      @queue_url = queue_url
      @body = body
      @attributes = attributes
    end

    def send_message
      @sqs.send_message({
        queue_url: @queue_url,
        message_body: @body,
        message_attributes: @attributes
      })
    end
  end
end
