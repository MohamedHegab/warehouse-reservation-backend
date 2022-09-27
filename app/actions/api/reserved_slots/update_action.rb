module Api
  module ReservedSlots
    class UpdateAction < ::Api::BaseAction
      def call(params)
        ReservedSlot.transaction(isolation: :serializable) do
          validated_data = yield validate(params)
          reserved_slot = yield find(params)
          business_hour = yield find_business_hour(reserved_slot, params)
          yield check_slot_is_available(business_hour, reserved_slot, params)
          reserved_slot = yield update(reserved_slot, validated_data.to_h)
          Success(reserved_slot)
        end
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

      def find_business_hour(reserved_slot, params)
        start_time = params.fetch(:start_time, reserved_slot.start_time).to_datetime
        business_hour =
          BusinessHour.by_date(
            start_time
          ).by_warehouse_id(params.fetch(:warehouse_id)).take
        if business_hour
          Success(business_hour)
        else
          Failure('Warehouse is closed')
        end
      end

      def check_slot_is_available(business_hour, reserved_slot, params)
        start_time = params.fetch(:start_time, reserved_slot.start_time)
        end_time = params.fetch(:end_time, reserved_slot.end_time)

        time_correct = CheckReservedSlotAvailable.new(
          business_hour:,
          start_reserve_time: start_time,
          end_reserve_time: end_time
        ).call
        if time_correct
          Success()
        else
          Failure('Warehouse is closed')
        end
      end
    end
  end
end
