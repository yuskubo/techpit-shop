# frozen_string_literal: true

class Registration < ApplicationRecord
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :agreement, acceptance: true, allow_nil: false, on: :create

  private

  def downcase_email
    self.email = email.downcase
  end
end
