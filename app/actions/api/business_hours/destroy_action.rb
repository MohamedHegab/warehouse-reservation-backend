module Api
  module BusinessHours
    class DestroyAction < ::Api::BaseAction
      def call(params)
        business_hour = yield find(params)
        yield destroy(business_hour)
        Success(business_hour)
      end

      private

      def find(params)
        business_hour = BusinessHour.find_by(
          id: params.fetch(:id),
          warehouse_id: params.fetch(:warehouse_id)
        )
        if business_hour
          Success(business_hour)
        else
          Failure(:find)
        end
      end

      def destroy(business_hour)
        Success(business_hour.destroy)
      end
    end
  end
end
