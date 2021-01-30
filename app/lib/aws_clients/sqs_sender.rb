# frozen_string_literal: true

module AwsClients
  class SqsSender
    def initialize(region, queue_url, body, attributes, group_id)
      @sqs = Aws::SQS::Client.new(region: region)
      @queue_url = queue_url
      @body = body
      @attributes = attributes
      @group_id = group_id
    end

    def send_message
      @sqs.send_message(
        {
          queue_url: @queue_url,
          message_body: @body,
          message_attributes: @attributes,
          message_deduplication_id: SecureRandom.uuid,
          message_group_id: @group_id
        }
      )
    rescue Aws::SQS::Errors::ServiceError => e
      Rails.logger.error("SQS メッセージ登録でエラーが発生しました. body: #{@body}, attributes: #{@attributes}")
      Rails.logger.error(e.message)
      Rails.logger.error(e.backtrace.join("\n"))
    end
  end
end
