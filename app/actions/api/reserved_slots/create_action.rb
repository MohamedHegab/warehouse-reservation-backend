module Api
  module ReservedSlots
    class CreateAction < ::Api::BaseAction
      def call(params)
        ReservedSlot.transaction(isolation: :serializable) do
          validated_data = yield validate(params)
          business_hour = yield find_business_hour(params)
          yield check_slot_is_available(business_hour, params)
          reserved_slot = yield persist(validated_data.to_h)
          yield publish_to_channel(reserved_slot)
          Success(reserved_slot)
        end
      end

      private

      def persist(data)
        reserved_slot = ReservedSlot.new(data)
        if reserved_slot.save
          Success(reserved_slot.reload)
        else
          Failure(reserved_slot.errors.full_messages)
        end
      end

      def publish_to_channel(reserved_slot)
        ActionCable.server.broadcast "warehouse_#{reserved_slot.warehouse_id}_reserved_slots_channel", {
          action: 'create',
          data: reserved_slot
        }
        Success()
      end

      def find_business_hour(params)
        business_hour =
          BusinessHour.by_date(
            params.fetch(:start_time).to_datetime
          ).by_warehouse_id(params.fetch(:warehouse_id)).take
        if business_hour
          Success(business_hour)
        else
          Failure('Warehouse is closed')
        end
      end

      def check_slot_is_available(business_hour, params)
        time_correct = CheckReservedSlotAvailable.new(
          business_hour:,
          start_reserve_time: params.fetch(:start_time),
          end_reserve_time: params.fetch(:end_time)
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
