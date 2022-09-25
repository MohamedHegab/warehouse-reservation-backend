require 'dry/schema'

module Api
  class ReservedSlotsController < ApiController
    def index
      api_action do |m|
        m.success do |reserved_slots|
          responds_with_resource(
            reserved_slots.map do |reserved_slot|
              serialize(reserved_slot:)
            end
          )
        end
      end
    end

    def create
      api_action do |m|
        m.success do |reserved_slot|
          responds_with_resource(serialize(reserved_slot:), status: :created)
        end
      end
    end

    def update
      api_action do |m|
        m.success do |reserved_slot|
          responds_with_resource(serialize(reserved_slot:))
        end
      end
    end

    def destroy
      api_action do |m|
        m.success do |reserved_slot|
          responds_with_resource(serialize(reserved_slot:), status: 204)
        end
      end
    end

    private

    def serialize(reserved_slot:)
      ReservedSlotPresenter.new(reserved_slot:).call
    end
  end
end
