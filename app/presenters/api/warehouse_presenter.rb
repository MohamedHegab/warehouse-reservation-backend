module Api
  class WarehousePresenter
    def initialize(warehouse:)
      @warehouse = warehouse
    end

    attr_reader :warehouse

    def call
      {
        id: warehouse.id,
        name: warehouse.name
      }
    end
  end
end
