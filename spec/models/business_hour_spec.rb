require 'rails_helper'

RSpec.describe BusinessHour, type: :model do
  subject { build :business_hour }

  it do
    should validate_inclusion_of(:day).in_range(0..6)
  end

  it { should validate_uniqueness_of(:day).scoped_to(:warehouse_id) }
  it { should validate_presence_of(:day) }
  it { should validate_presence_of(:open_time) }
  it { should validate_presence_of(:close_time) }

  it 'close time format valid' do
    business_hour = build(:business_hour, close_time: '0800')
    expect(business_hour).to_not be_valid
  end

  it 'open time format valid' do
    business_hour = build(:business_hour, open_time: '0800')
    expect(business_hour).to_not be_valid
  end

  it 'close_time more than to the open_time' do
    business_hour = build(:business_hour, open_time: '09:00', close_time: '08:00')
    expect(business_hour).to_not be_valid
  end
end
