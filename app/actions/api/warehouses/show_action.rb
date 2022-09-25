module Api
  module Warehouses
    class ShowAction < ::Api::BaseAction
      def call(params)
        warehouse = yield find(params)
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
    end
  end
end
