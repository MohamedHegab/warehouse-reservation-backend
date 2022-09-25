module Api
  class ReservedSlotPresenter
    def initialize(reserved_slot:)
      @reserved_slot = reserved_slot
    end

    attr_reader :reserved_slot

    def call
      {
        uuid: reserved_slot.uuid,
        reservation_name: reserved_slot.reservation_name,
        start_time: reserved_slot.start_time,
        end_time: reserved_slot.end_time,
        warehouse_id: reserved_slot.warehouse_id
      }
    end
  end
end
