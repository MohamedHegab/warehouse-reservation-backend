class Warehouse < ApplicationRecord
  # Validations
  validates_presence_of :name
end
