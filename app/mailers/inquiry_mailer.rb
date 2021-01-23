class InquiryMailer < ApplicationMailer
  def inquiry(inquirer, subject)
    @last_name = inquirer.last_name
    mail(to: inquirer.email, subject: subject)
  end
end
