class Organization < ActiveRecord::Base
  belongs_to :country
  has_many :activities
  has_many :users, :through => :activities

  validates_uniqueness_of :title
  validates_presence_of :country
end
