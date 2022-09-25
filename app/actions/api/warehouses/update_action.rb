module Api
  module Warehouses
    class UpdateAction < ::Api::BaseAction
      def call(params)
        validated_data = yield validate(params)
        warehouse = yield find(params)
        warehouse = yield update(warehouse, validated_data.to_h)
        Success(warehouse)
      end

      private

      def find(params)
        warehouse = Warehouse.find_by(id: params.fetch(:id))
        if warehouse
          Success(warehouse)
        else
          Failure(:find)
        end
      end

      def update(warehouse, data)
        if warehouse.update(data)
          Success(warehouse)
        else
          Failure(warehouse.errors.full_messages)
        end
      end
    end
  end
end
