class ReservedSlot < ApplicationRecord
  # Associations
  belongs_to :warehouse, required: true

  # Validations
  validates_presence_of :reservation_name, :start_time, :end_time
  validate :validate_overlapping

  scope :by_warehouse_id, ->(id) { where(warehouse_id: id) }
  scope :overlaps_range,
        lambda { |range|
          t = arel_table
          where(t[:start_time].lt(range.last))
            .where(t[:end_time].gt(range.first))
        }

  def validate_overlapping
    return unless warehouse_overlapping_slots.first

    errors.add(:start_time, 'Overlapping with other slot')
  end

  def warehouse_overlapping_slots
    return ReservedSlot.none unless start_time && end_time

    ReservedSlot.by_warehouse_id(warehouse_id).overlaps_range(range)
  end

  def range
    start_time..end_time
  end
end
