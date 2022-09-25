module Api
  module ReservedSlots
    class IndexAction < ::Api::BaseAction
      def call(params)
        reserved_slots = yield business_hours_scope(params)
        Success(reserved_slots.to_a)
      end

      private

      def business_hours_scope(params)
        Success(ReservedSlot.where(warehouse_id: params.fetch(:warehouse_id)))
      end
    end
  end
end
