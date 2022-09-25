module Api
  module BusinessHours
    class CreateAction < ::Api::BaseAction
      def call(params)
        validated_data = yield validate(params)
        business_hour = yield persist(validated_data.to_h)
        Success(business_hour)
      end

      private

      def persist(data)
        business_hour = BusinessHour.new(data)
        if business_hour.save
          Success(business_hour)
        else
          Failure(business_hour.errors.full_messages)
        end
      end
    end
  end
end
