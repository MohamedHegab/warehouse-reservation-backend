module Api
  class BusinessHourPresenter
    def initialize(business_hour:)
      @business_hour = business_hour
    end

    attr_reader :business_hour

    def call
      {
        id: business_hour.id,
        day: business_hour.day,
        warehouse_id: business_hour.warehouse_id,
        open_time: business_hour.open_time,
        close_time: business_hour.close_time
      }
    end
  end
end
