class ProductMailer < ApplicationMailer

  
  def product_created
    
    mail(
    from: "aman7@gmail.com",
    to: User.first.email,
    cc: User.all.pluck(:email),
    subject: "new post created"
    )
  end
end
