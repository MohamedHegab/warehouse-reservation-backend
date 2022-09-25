require 'dry/monads'
require 'dry/monads/do'

module Api
  class BaseAction
    include Dry::Monads[:result, :do]

    def validate(params)
      result = resolve_schema.new.call(params)
      if result.success?
        Success(result)
      else
        Failure([:validate, result.errors.to_h])
      end
    end

    private

    def resolve_schema
      [
        self.class.name.deconstantize,
        self.class.name.demodulize.underscore.gsub('_action', '_schema').classify
      ].join('::').constantize
    end
  end
end
