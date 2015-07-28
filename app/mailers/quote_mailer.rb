class QuoteMailer < ApplicationMailer

  def confirmation_to_client(quote)
    @quote = quote
    @client = @quote.quote_user
    email_with_name = "#{@client.full_name} <#{@client.email}>"
    mail(to: email_with_name, subject: "Bandwidth quote request number #{@quote.number} submitted")
  end

  def confirmation_to_carrier(quote, company_user)
     @quote = quote
     @quote_user = @quote.quote_user
     @company_user = company_user
     email_with_name = "#{@company_user.full_name} <#{@company_user.email}>"
     mail(to: email_with_name, subject: "Bandwidth quote request received")
  end

end
