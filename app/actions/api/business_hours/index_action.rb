module Api
  module BusinessHours
    class IndexAction < ::Api::BaseAction
      def call(params)
        business_hours = yield business_hours_scope(params)
        Success(business_hours.to_a)
      end

      private

      def business_hours_scope(params)
        Success(BusinessHour.where(warehouse_id: params.fetch(:warehouse_id)))
      end
    end
  end
end
