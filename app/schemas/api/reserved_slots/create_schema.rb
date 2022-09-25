module Api
  module ReservedSlots
    class CreateSchema < Dry::Validation::Contract
      params do
        required(:reservation_name).filled(:string)
        required(:warehouse_id).filled(:integer)
        required(:start_time).filled(:date_time)
        required(:end_time).filled(:date_time)
      end
    end
  end
end
