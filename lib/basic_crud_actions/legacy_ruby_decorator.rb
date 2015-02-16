require_relative 'hash_helper'

module BasicCrudActions
  module ActsAsCrud
    module LegacyRubyDecorator
      # This module backports the refinement functionality in the app to
      # Ruby 1.9.3
      class ResponseDecorator < SimpleDelegator

        def class
          __getobj__.class
        end

        def decorate(obj)
          self.class.new(obj)
        end

        def filter(args = {}, &block)
          return [] unless ActiveRecord::Relation.descendants
                             .include? __getobj__.class
          return ResponseDecorator.new(instance_eval(&block)).filter(args) if block_given?
          key, val = HashHelper.pop_hash_val(args)
          key ? ResponseDecorator.new(where(key => val)).filter(args) : self
        end

        def save(args_with_context)
          context = args_with_context.context
          if super(*args_with_context.args)
            success_obj(context)
          else
            failure_obj(context)
          end
        end

        def to_model
          __getobj__
        end

        def save!(args_with_context)
          super(*args_with_context.args)
          success_obj(args_with_context.context)
        end

        def update_attributes(args_with_context)
          context = args_with_context.context
          if super(*args_with_context.args)
            success_obj(context)
          else
            failure_obj(context)
          end
        end

        def update_attributes!(args_with_context)
          super(*args_with_context.args)
          success_obj(args_with_context.context)
        end

        private

        def failure_obj(controller)
          ResponseObjects::Failure.new(controller)
        end

        def success_obj(controller)
          ResponseObjects::Success.new(controller)
        end
      end
    end
  end
end
