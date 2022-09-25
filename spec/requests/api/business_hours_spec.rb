require 'rails_helper'

RSpec.describe 'BusinessHours', type: :request do
  let(:warehouse) { create(:warehouse) }

  describe 'GET /index' do
    let!(:business_hour) { create(:business_hour, day: 0, warehouse:) }
    let!(:business_hour) { create(:business_hour, day: 1, warehouse:) }
    let!(:another_business_hours) { create_list(:business_hour, 5) }

    before do
      get api_warehouse_business_hours_path(warehouse.id)
    end

    it 'should return status 200' do
      expect(response.status).to eq 200
    end

    it 'should list all warehouses' do
      expect(json.size).to eq warehouse.business_hours.size
    end
  end

  describe 'POST /create' do
    context 'valid attributes' do
      let(:valid_attributes) do
        {
          day: 0,
          open_time: '08:00',
          close_time: '16:00'
        }
      end

      before do
        post api_warehouse_business_hours_path(warehouse.id), params: valid_attributes
      end

      it 'should return status 201' do
        expect(response.status).to eq 201
      end

      it 'should create warehouse' do
        expect(json['id']).not_to eq nil
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) do
        {
          day: 0,
          open_time: '0800',
          close_time: '16:00'
        }
      end

      before do
        post api_warehouse_business_hours_path(warehouse.id), params: invalid_attributes
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
    let!(:business_hour) { create(:business_hour, warehouse:) }

    context 'valid attributes' do
      let(:close_time) { '18:00' }
      let(:valid_attributes) { { close_time: } }

      before do
        put api_warehouse_business_hour_path(warehouse.id, business_hour.id), params: valid_attributes
      end

      it 'should return status 200' do
        expect(response.status).to eq 200
      end

      it 'should create warehouse' do
        expect(json['close_time']).to eq close_time
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { close_time: nil } }

      before do
        put api_warehouse_business_hour_path(warehouse.id, business_hour.id), params: invalid_attributes
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
    let!(:business_hour) { create(:business_hour, warehouse:) }

    before do
      delete api_warehouse_business_hour_path(warehouse.id, business_hour.id)
    end

    it 'should return status 204' do
      expect(response.status).to eq 204
    end

    it 'should destroy warehouse' do
      expect(warehouse.business_hours.size).to eq 0
    end
  end
end
