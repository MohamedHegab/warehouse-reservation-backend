module Api
  module ReservedSlots
    class CreateAction < ::Api::BaseAction
      def call(params)
        validated_data = yield validate(params)
        reserved_slot = yield persist(validated_data.to_h)
        Success(reserved_slot)
      end

      private

      def persist(data)
        reserved_slot = ReservedSlot.new(data)
        if reserved_slot.save
          Success(reserved_slot)
        else
          Failure(reserved_slot.errors.full_messages)
        end
      end
    end
  end
end
