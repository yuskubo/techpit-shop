# frozen_string_literal: true

class Speaker < ApplicationRecord
  has_many :events, dependent: :destroy
end
