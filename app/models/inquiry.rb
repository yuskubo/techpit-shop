class Inquiry < ApplicationRecord
  before_save :downcase_email
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  validates_acceptance_of :agreement, allow_nil: false, message: 'プライバシーポリシーの同意が必要です', on: :create

  private

  def downcase_email
    self.email = email.downcase
  end
end
