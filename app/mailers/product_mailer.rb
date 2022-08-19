class ProductMailer < ApplicationMailer

  def product_created(user)
    @user = user
    mail(
      from: "aman7@gmail.com",
      to: @user.email,
      cc: User.all.pluck(:email),
      subject: "new post created"
    )
  end
end
