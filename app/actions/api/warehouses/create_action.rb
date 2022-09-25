module Api
  module Warehouses
    class CreateAction < ::Api::BaseAction
      def call(params)
        validated_data = yield validate(params)
        warehouse = yield persist(validated_data.to_h)
        Success(warehouse)
      end

      private

      def persist(data)
        warehouse = Warehouse.new(data)
        if warehouse.save
          Success(warehouse)
        else
          Failure(warehouse.errors.full_messages)
        end
      end
    end
  end
end
