require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "eShop Store Order Confirmation", mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["eshop@example.com"], mail.from
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "eShop Store Order Shipped", mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["eshop@example.com"], mail.from
  end
end
