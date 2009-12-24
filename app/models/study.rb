class Study < ActiveRecord::Base
  belongs_to :user
  belongs_to :university
  belongs_to :study_type

  def country_id
  end

end
