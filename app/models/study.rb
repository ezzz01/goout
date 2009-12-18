class Study < ActiveRecord::Base
  belongs_to :user
  belongs_to :university
  #has_one :study_type
end
