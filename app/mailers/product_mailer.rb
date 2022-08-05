class ProductMailer < ApplicationMailer

  
  def product_created
    @greeting = "Hi"

    mail(
    from: "vandna23@gmail.com",
    to: User.first.email,
    cc: User.all.pluck(:email),
    subject: "new post created"
    )
  end
end
