class BusinessHour < ApplicationRecord
  belongs_to :warehouse

  scope :by_date, ->(date) { where(arel_table[:day].eq(date.wday)) }
  scope :by_warehouse_id, ->(warehouse_id) { where(arel_table[:warehouse_id].eq(warehouse_id)) }

  validates_presence_of :day, :open_time, :close_time
  validates_inclusion_of :day, in: 0..6
  validates :day, uniqueness: { scope: :warehouse_id }
  validate :open_time_format
  validate :close_time_format
  validate :close_time_more_than_open_time

  def open_time_format
    return if open_time_parsed

    errors.add(:open_time, 'Wrong format should be hh:mm')
  end

  def close_time_format
    return if close_time_parsed

    errors.add(:close_time, 'Wrong format should be hh:mm')
  end

  def close_time_more_than_open_time
    return unless open_time_parsed && close_time_parsed
    return if open_time_parsed < close_time_parsed

    errors.add(:close_time, 'Must be bigger than open time')
  end

  def open_time_parsed
    parse(open_time)
  end

  def close_time_parsed
    parse(close_time)
  end

  def range
    open_time_parsed..close_time_parsed
  end

  def parse(time_str)
    return unless time_str

    Time.parse(time_str)
  rescue ArgumentError
    nil
  end
end
