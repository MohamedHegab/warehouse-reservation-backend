module Api
  module ReservedSlots
    class UpdateSchema < Dry::Validation::Contract
      params do
        required(:uuid).filled(:string)
        required(:warehouse_id).filled(:integer)
        optional(:reservation_name).filled(:string)
        optional(:start_time).filled(:date_time)
        optional(:end_time).filled(:date_time)
      end
    end
  end
end
