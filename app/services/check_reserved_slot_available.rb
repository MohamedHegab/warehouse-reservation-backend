class CheckReservedSlotAvailable
  def initialize(business_hour:, start_reserve_time:, end_reserve_time:)
    @business_hour = business_hour
    @start_reserve_time = start_reserve_time
    @end_reserve_time = end_reserve_time
  end

  attr_reader :business_hour, :start_reserve_time, :end_reserve_time

  def call
    open_time = business_hour.open_time_parsed.seconds_since_midnight
    close_time = business_hour.close_time_parsed.seconds_since_midnight
    start_reserved_time = start_reserve_time.to_datetime.seconds_since_midnight
    end_reserved_time = end_reserve_time.to_datetime.seconds_since_midnight

    end_reserved_time <= close_time && start_reserved_time >= open_time
  end
end
