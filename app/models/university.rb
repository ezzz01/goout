class University < ActiveRecord::Base
  belongs_to :country
  has_many :studies
  has_many :users, :through => :studies
end
