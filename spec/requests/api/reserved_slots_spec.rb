require 'rails_helper'

RSpec.describe 'ReservedSlots', type: :request do
  let(:warehouse) { create(:warehouse) }

  before do
    Timecop.freeze(DateTime.new(2022, 9, 22, 18))
  end

  describe 'GET /index' do
    let!(:reserved_slot) { create(:reserved_slot, warehouse:) }
    let!(:reserved_slot) { create(:reserved_slot, warehouse:) }
    let!(:another_reserved_slots) { create_list(:reserved_slot, 5) }

    before do
      get api_warehouse_reserved_slots_path(warehouse.id)
    end

    it 'should return status 200' do
      expect(response.status).to eq 200
    end

    it 'should list all warehouses' do
      expect(json.size).to eq warehouse.reserved_slots.size
    end
  end

  describe 'POST /create' do
    let!(:business_hour) { create(:business_hour, day: Date.today.wday, warehouse:) }
    let(:valid_attributes) do
      {
        reservation_name: 'Name',
        start_time: 3.hours.ago,
        end_time: 3.hours.from_now
      }
    end

    context 'valid attributes' do
      before do
        post api_warehouse_reserved_slots_path(warehouse.id), params: valid_attributes
      end

      it 'should return status 201' do
        expect(response.status).to eq 201
      end

      it 'should reserve the slot' do
        expect(json['reservation_name']).not_to eq nil
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) do
        {
          reservation_name: 'Name',
          start_time: 'Name',
          end_time: 3.hours.from_now
        }
      end

      before do
        post api_warehouse_reserved_slots_path(warehouse.id), params: invalid_attributes
      end

      it 'should return status 422' do
        expect(response.status).to eq 422
      end

      it 'should not create warehouse' do
        expect(json.keys).to contain_exactly('errors')
      end
    end

    context 'no business hour' do
      let(:business_hour) { nil }

      before do
        post api_warehouse_reserved_slots_path(warehouse.id), params: valid_attributes
      end

      it 'should return status 422' do
        expect(response.status).to eq 422
      end

      it 'should not create warehouse' do
        expect(json.keys).to contain_exactly('errors')
      end
    end
  end

  describe 'PUT /update' do
    let!(:reserved_slot) { create(:reserved_slot, warehouse:) }
    let!(:business_hour) { create(:business_hour, day: reserved_slot.start_time.wday, warehouse:) }
    let(:reservation_name) { 'Name' }
    let(:valid_attributes) { { reservation_name: } }

    context 'valid attributes' do
      before do
        put api_warehouse_reserved_slot_path(
          warehouse.id,
          reserved_slot.uuid
        ), params: valid_attributes
      end

      it 'should return status 200' do
        expect(response.status).to eq 200
      end

      it 'should create warehouse' do
        expect(json['reservation_name']).to eq reservation_name
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { reservation_name: nil } }

      before do
        put api_warehouse_reserved_slot_path(
          warehouse.id,
          reserved_slot.uuid
        ), params: invalid_attributes
      end

      it 'should return status 422' do
        expect(response.status).to eq 422
      end

      it 'should not create warehouse' do
        expect(json.keys).to contain_exactly('errors')
      end
    end

    context 'no business hour' do
      let(:business_hour) { nil }

      before do
        put api_warehouse_reserved_slot_path(
          warehouse.id,
          reserved_slot.uuid
        ), params: valid_attributes
      end

      it 'should return status 422' do
        expect(response.status).to eq 422
      end

      it 'should not create warehouse' do
        expect(json.keys).to contain_exactly('errors')
      end
    end
  end

  describe 'Destroy /destroy' do
    let!(:reserved_slot) { create(:reserved_slot, warehouse:) }

    before do
      delete api_warehouse_reserved_slot_path(
        warehouse.id,
        reserved_slot.uuid
      )
    end

    it 'should return status 204' do
      expect(response.status).to eq 204
    end

    it 'should destroy warehouse' do
      expect(warehouse.reserved_slots.size).to eq 0
    end
  end
end
