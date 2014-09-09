require 'aws/sqs'
require 'message'

class MessageSqs
  attr_reader :name
  def initialize(name)
    @name = name
    @queue = AWS::SQS.new.queues.create(@name)
  end

  def enq(msg)
    @queue.send_message(msg)
  end
  alias :<< :enq

  def deq(size=1, &block)
    @queue.receive_message(:limit => size) do |msg|
      block.call(msg.body)
    end
  end

  def size
    @queue.approximate_number_of_messages
  end
end

Message.queue.adapters[:sqs] = MessageSqs
Message.queue.adapter = :sqs