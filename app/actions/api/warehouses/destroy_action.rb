module Api
  module Warehouses
    class DestroyAction < ::Api::BaseAction
      def call(params)
        warehouse = yield find(params)
        yield destroy(warehouse)
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

      def destroy(warehouse)
        Success(warehouse.destroy)
      end
    end
  end
end
