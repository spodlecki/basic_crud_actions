require 'rails_helper'
require_relative '../../lib/basic_crud_actions/legacy_ruby_decorator'

describe BasicCrudActions::ActsAsCrud::LegacyRubyDecorator::ResponseDecorator do
  describe '.filter' do
    context 'its delgate is not descended from ActiveRecord::Relation' do
      it 'returns nil' do
        expect(described_class.new('foo').filter).to eq []
      end
    end
  end

  context 'block passed' do
    it 'evaluates the block passed for the relation' do
      3.times do
        ShortTestModel.create filter_flag: false
      end
      filtered = ShortTestModel.create filter_flag: true
      expect(described_class.new(ShortTestModel.all)
               .filter { where(filter_flag: true) })
               .to eq ShortTestModel.where(filter_flag: true)
    end
  end

  context 'args passed' do
    it 'evalutates each key value pair in a where clause' do
      3.times do
         ShortTestModel.create filter_flag: true, second_filter_flag: false
      end
      filtered =ShortTestModel.create filter_flag: true,
                                      second_filter_flag: true
      expect(described_class.new(ShortTestModel.all)
               .filter(filter_flag: true, second_filter_flag: true))
               .to eq ShortTestModel
                        .where(filter_flag: true, second_filter_flag: true)

    end
  end

  context 'both block and args passed' do
    it 'filters by the block and the args' do
      3.times do
        ShortTestModel.create filter_flag: true, second_filter_flag: false
      end
      ShortTestModel.create filter_flag: true, second_filter_flag: true
      test_decorator = described_class.new(ShortTestModel.all)
      filtered = test_decorator.filter(filter_flag: true) do
        where(second_filter_flag: true)
      end
      filtered_ids = filtered.map(&:id)
      expect(filtered_ids).to eq ShortTestModel
                                   .where(filter_flag: true,
                                          second_filter_flag: true).map(&:id)
    end
  end
end
