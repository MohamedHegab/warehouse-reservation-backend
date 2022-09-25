module Api
  module BusinessHours
    class CreateSchema < Dry::Validation::Contract
      params do
        required(:day).filled(:integer)
        required(:warehouse_id).filled(:integer)
        required(:open_time).filled(:string)
        required(:close_time).filled(:string)
      end
    end
  end
end
