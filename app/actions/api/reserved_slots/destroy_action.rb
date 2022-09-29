module Api
  module ReservedSlots
    class DestroyAction < ::Api::BaseAction
      def call(params)
        reserved_slot = yield find(params)
        yield destroy(reserved_slot)
        yield publish_to_channel(reserved_slot)
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

      def publish_to_channel(reserved_slot)
        ActionCable.server.broadcast "warehouse_#{reserved_slot.warehouse_id}_reserved_slots_channel", {
          action: 'destroy',
          data: reserved_slot
        }
        Success()
      end
    end
  end
end
