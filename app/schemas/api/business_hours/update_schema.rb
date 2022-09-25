module Api
  module BusinessHours
    class UpdateSchema < Dry::Validation::Contract
      params do
        required(:id).filled(:integer)
        required(:warehouse_id).filled(:integer)
        optional(:day).filled(:integer)
        optional(:open_time).filled(:string)
        optional(:close_time).filled(:string)
      end
    end
  end
end
