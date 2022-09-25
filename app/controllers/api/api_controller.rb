require 'dry/matcher/result_matcher'

module Api
  class ApiController < ApplicationController
    include Dry::Monads[:result]

    private

    def resolve_action
      [
        self.class.name.deconstantize,
        controller_name.camelize,
        "#{action_name}_action".classify
      ].join('::').constantize
    end

    def api_action(input: params.to_unsafe_h)
      result = resolve_action.new.call(input)
      Dry::Matcher::ResultMatcher.call(result) do |m|
        yield(m)

        m.failure(:validate) do |_key, errors|
          responds_with_errors(errors, status: 422)
        end

        m.failure(:find) do
          head 404
        end

        m.failure do |errors|
          responds_with_errors(errors, status: 422)
        end
      end
    end

    def responds_with_errors(errors, status:)
      render json: { errors: }, status:
    end

    def responds_with_resource(resource, status: 200, meta: nil)
      render json: resource, status:, meta:
    end
  end
end
