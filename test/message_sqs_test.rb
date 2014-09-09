require "test_helper"

class MessageSqsTest < Test::Unit::TestCase
  def test_enq_deq
    q = Message.queue("message-sqs-test-#{Time.now.to_i}")
    q << 'msg'
    assert_equal 1, q.size
    result = q.deq do |msg|
      "received #{msg}"
    end
    assert_equal 'received msg', result
  end
end