require 'rails_helper'

RSpec.describe 'Warehouses', type: :request do
  describe 'GET /index' do
    let!(:warehouses) { create_list(:warehouse, 10) }

    before do
      get api_warehouses_path
    end

    it 'should return status 200' do
      expect(response.status).to eq 200
    end

    it 'should list all warehouses' do
      expect(json.size).to eq warehouses.size
    end
  end

  describe 'GET show' do
    let!(:warehouse) { create(:warehouse) }

    context 'valid attributes' do
      before do
        get api_warehouse_path(warehouse.id)
      end

      it 'should return status 200' do
        expect(response.status).to eq 200
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { name: nil } }

      before do
        put api_warehouse_path(warehouse.id), params: invalid_attributes
      end

      it 'should return status 422' do
        expect(response.status).to eq 422
      end

      it 'should not create warehouse' do
        expect(json.keys).to contain_exactly('errors')
      end
    end
  end

  describe 'POST /create' do
    context 'valid attributes' do
      let(:valid_attributes) { { name: 'warehouse 1' } }

      before do
        post api_warehouses_path, params: valid_attributes
      end

      it 'should return status 201' do
        expect(response.status).to eq 201
      end

      it 'should create warehouse' do
        expect(json['id']).not_to eq nil
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { name: nil } }

      before do
        post api_warehouses_path, params: invalid_attributes
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
    let!(:warehouse) { create(:warehouse) }

    context 'valid attributes' do
      let(:new_warehouse_name) { 'new warehouse' }
      let(:valid_attributes) { { name: new_warehouse_name } }

      before do
        put api_warehouse_path(warehouse.id), params: valid_attributes
      end

      it 'should return status 200' do
        expect(response.status).to eq 200
      end

      it 'should create warehouse' do
        expect(json['name']).to eq new_warehouse_name
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { name: nil } }

      before do
        put api_warehouse_path(warehouse.id), params: invalid_attributes
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
    let!(:warehouse) { create(:warehouse) }

    before do
      delete api_warehouse_path(warehouse.id)
    end

    it 'should return status 204' do
      expect(response.status).to eq 204
    end

    it 'should destroy warehouse' do
      expect(Warehouse.all.size).to eq 0
    end
  end
end
