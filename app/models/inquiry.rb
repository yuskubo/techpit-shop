class Inquiry < ApplicationRecord
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates_acceptance_of :agreement, allow_nil: false, on: :create

  private

  def downcase_email
    self.email = email.downcase
  end
end
