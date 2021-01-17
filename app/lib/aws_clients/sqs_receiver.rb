module AwsClients
  class SqsReceiver
    def initialize(region, queue_url, max_number:)
      @sqs = Aws::SQS::Client.new(region: region)
      @queue_url = queue_url
      @max_number = max_number
    end

    def receive_messages
      response = @sqs.receive_message({
        queue_url: @queue_url,
        message_attribute_names: ['All'],
        max_number_of_messages: @max_number,
        wait_time_seconds: 0
      })
    end

    def delete_messages(response)
      response.messages.each do |message|
        @sqs.delete_message({
          queue_url: @queue_url,
          receipt_handle: message.receipt_handle
        })
      end
    end
  end
end
