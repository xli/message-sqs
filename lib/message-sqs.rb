require 'aws-sdk'
require 'message'

class MessageSqs

  attr_reader :name
  # options:
  # => :create_queue, default true
  def initialize(name, options={})
    @name = name
    @client = Aws::SQS::Client.new
    @queue_url = options[:queue_url] || @client.create_queue(:queue_name => @name)[:queue_url]
  end

  def enq(msg)
    @client.send_message(req_params(:message_body => msg))
  end
  alias :<< :enq

  def deq(size=1, &block)
    msgs = @client.receive_message(req_params(:max_number_of_messages => size))
    Array(msgs[:messages]).each do |msg|
      begin
        block.call(msg[:body])
      ensure
        @client.delete_message(req_params(:receipt_handle => msg[:receipt_handle]))
      end
    end
  end

  def size
    attr_name = 'ApproximateNumberOfMessages'
    ret = @client.get_queue_attributes(req_params(:attribute_names => [attr_name]))
    ret[:attributes][attr_name].to_i
  end
  
  private
  def req_params(params)
    {:queue_url => @queue_url}.merge(params)
  end
end

Message.queue.adapters[:sqs] = MessageSqs
