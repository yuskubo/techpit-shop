# frozen_string_literal: true

class RegistrationMailer < ApplicationMailer
  def registration(registration, subject)
    @last_name = registration.last_name
    mail(to: registration.email, subject: subject)
  end
end
