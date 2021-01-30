# frozen_string_literal: true

module AwsClients
  class SnsPublisher
    def initialize(region, topic_arn, message, attributes, group_id)
      @sns = Aws::SNS::Client.new(region: region)
      @topic_arn = topic_arn
      @message = message
      @attributes = attributes
      @group_id = group_id
    end

    def publish_message
      @sns.publish(
        {
          topic_arn: @topic_arn,
          message: @message,
          message_attributes: @attributes,
          message_deduplication_id: SecureRandom.uuid,
          message_group_id: @group_id
        }
      )
    rescue Aws::SQS::Errors::ServiceError => e
      Rails.logger.error("SNS メッセージ配信でエラーが発生しました. body: #{@body}, attributes: #{@attributes}")
      Rails.logger.error(e.message)
      Rails.logger.error(e.backtrace.join("\n"))
    end
  end
end
