class University < ActiveRecord::Base
  belongs_to :country
  has_many :studies
  has_many :users, :through => :studies

  validates_uniqueness_of :title
  validates_presence_of :country
end
