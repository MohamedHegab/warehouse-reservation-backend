class Warehouse < ApplicationRecord
  # Associations
  has_many :business_hours
  has_many :reserved_slots

  # Validations
  validates_presence_of :name
end
