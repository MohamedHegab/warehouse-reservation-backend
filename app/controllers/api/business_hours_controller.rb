require 'dry/schema'

module Api
  class BusinessHoursController < ApiController
    def index
      api_action do |m|
        m.success do |business_hours|
          responds_with_resource(
            business_hours.map do |business_hour|
              serialize(business_hour:)
            end
          )
        end
      end
    end

    def create
      api_action do |m|
        m.success do |business_hour|
          responds_with_resource(serialize(business_hour:), status: :created)
        end
      end
    end

    def update
      api_action do |m|
        m.success do |business_hour|
          responds_with_resource(serialize(business_hour:))
        end
      end
    end

    def destroy
      api_action do |m|
        m.success do |business_hour|
          responds_with_resource(serialize(business_hour:), status: 204)
        end
      end
    end

    private

    def serialize(business_hour:)
      BusinessHourPresenter.new(business_hour:).call
    end
  end
end
