module Api
  module Warehouses
    class CreateSchema < Dry::Validation::Contract
      params do
        required(:name).filled(:string)
      end
    end
  end
end
