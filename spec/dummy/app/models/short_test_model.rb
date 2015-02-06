class ShortTestModel < ActiveRecord::Base
  validates_uniqueness_of :id
end
