class Country < ActiveRecord::Base
  has_many :universities

  validates_uniqueness_of :title
end
