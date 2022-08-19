class Product < ApplicationRecord
  self.per_page = 10
  belongs_to :user, optional: true
  after_save :send_email

  def send_email
    ProductMailer.delay(run_at: 15.seconds.from_now).product_created(User.first)
    # ProductMailer.product_created(User.first).deliver_later(wait: 3.minutes)
  end
end
