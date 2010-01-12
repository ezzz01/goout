class Country < ActiveRecord::Base
  has_many :organizations

  validates_uniqueness_of :title
end
