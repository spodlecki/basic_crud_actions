require 'rails_helper'


if RUBY_VERSION >= '2.0.0'
  describe ShortTestModel do
    require_relative '../../lib/basic_crud_actions/save_returns_status_objects'
    using BasicCrudActions::ActsAsCrud::SaveReturnsStatusObjects

    def expect_success_object(model)
      expect(model.save(args_with_context))
        .to be_a_kind_of BasicCrudActions::ResponseObjects::Success
    end

    def args_with_context
      BasicCrudActions::ArgsWithContext.new(ShortTestModelsController.new)
    end

    let(:test_model) { ShortTestModel.new }
    describe '.save' do
      context 'valid params' do
        it 'returns a success object' do
          expect_success_object(test_model)
        end
      end

      context 'invald_params' do
        it 'returns a failure object' do
          first_model = ShortTestModel.create
          test_model.id = first_model.id
          expect(test_model.save(args_with_context))
            .to be_a_kind_of BasicCrudActions::ResponseObjects::Failure
        end
      end
    end

    describe '.save!' do
      context 'valid params' do
        it 'returns a success object' do
          expect(test_model.save!(args_with_context)).to be_a_kind_of BasicCrudActions::ResponseObjects::Success
        end
      end
      context 'invalid params' do
        it 'raises' do
          first_model = ShortTestModel.create
          test_model.id = first_model.id
          expect { test_model.save!(args_with_context) }.to raise_exception
        end
      end
    end

    describe '.update_attributes' do
      context 'valid params' do
        it 'returns a success object' do
          test_model = ShortTestModel.create
          expect(test_model.update_attributes(BasicCrudActions::ArgsWithContext.new(ShortTestModelsController.new, id: test_model.id + 1))).to be_a_kind_of BasicCrudActions::ResponseObjects::Success
        end
      end
    end
  end
end
