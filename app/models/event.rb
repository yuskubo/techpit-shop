# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :speaker
  has_many :registrations, dependent: :destroy
end
