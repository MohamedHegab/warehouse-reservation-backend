module Api
  module ReservedSlots
    class UpdateAction < ::Api::BaseAction
      def call(params)
        validated_data = yield validate(params)
        reserved_slot = yield find(params)
        reserved_slot = yield update(reserved_slot, validated_data.to_h)
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

      def update(reserved_slot, data)
        if reserved_slot.update(data)
          Success(reserved_slot)
        else
          Failure(reserved_slot.errors.full_messages)
        end
      end
    end
  end
end
