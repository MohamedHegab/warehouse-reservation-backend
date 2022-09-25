module Api
  module ReservedSlots
    class DestroyAction < ::Api::BaseAction
      def call(params)
        reserved_slot = yield find(params)
        yield destroy(reserved_slot)
        Success(reserved_slot)
      end

      private

      def find(params)
        reserved_slot = ReservedSlot.find_by(
          uuid: params.fetch(:uuid),
          warehouse_id: params.fetch(:warehouse_id)
        )
        if reserved_slot
          Success(reserved_slot)
        else
          Failure(:find)
        end
      end

      def destroy(reserved_slot)
        Success(reserved_slot.destroy)
      end
    end
  end
end
