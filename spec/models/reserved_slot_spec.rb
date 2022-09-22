require 'rails_helper'

RSpec.describe ReservedSlot, type: :model do
  subject { build :reserved_slot }

  it { should validate_presence_of(:reservation_name) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }

  before do
    Timecop.freeze(DateTime.new(2022, 9, 22, 18))
  end

  it 'reserved slots must not overlap' do
    slot = create(:reserved_slot, start_time: 3.hour.ago, end_time: 1.hour.ago)
    overlap_slot =
      build(:reserved_slot,
            warehouse: slot.warehouse,
            start_time: 2.hour.ago, end_time: Time.now)
    expect(overlap_slot).to_not be_valid
  end
end
