require "test_helper"

class ProductMailerTest < ActionMailer::TestCase
  test "product_created" do
    mail = ProductMailer.product_created
    assert_equal "Product created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
