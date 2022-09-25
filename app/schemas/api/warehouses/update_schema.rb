module Api
  module Warehouses
    class UpdateSchema < Dry::Validation::Contract
      params do
        required(:id).filled(:integer)
        optional(:name).filled(:string)
      end
    end
  end
end
