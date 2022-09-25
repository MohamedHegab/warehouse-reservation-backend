module Api
  module BusinessHours
    class UpdateAction < ::Api::BaseAction
      def call(params)
        validated_data = yield validate(params)
        business_hour = yield find(params)
        business_hour = yield update(business_hour, validated_data.to_h)
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

      def update(business_hour, data)
        if business_hour.update(data)
          Success(business_hour)
        else
          Failure(business_hour.errors.full_messages)
        end
      end
    end
  end
end
