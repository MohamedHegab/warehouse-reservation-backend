require 'dry/schema'

module Api
  class WarehousesController < ApiController
    def index
      json = Warehouse.all
                      .map { |warehouse| serialize(warehouse:) }

      render json:
    end

    def show
      api_action do |m|
        m.success do |warehouse|
          responds_with_resource(serialize(warehouse:))
        end
      end
    end

    def create
      api_action do |m|
        m.success do |warehouse|
          responds_with_resource(serialize(warehouse:), status: :created)
        end
      end
    end

    def update
      api_action do |m|
        m.success do |warehouse|
          responds_with_resource(serialize(warehouse:))
        end
      end
    end

    def destroy
      api_action do |m|
        m.success do |warehouse|
          responds_with_resource(serialize(warehouse:), status: 204)
        end
      end
    end

    private

    def serialize(warehouse:)
      WarehousePresenter.new(warehouse:).call
    end
  end
end
