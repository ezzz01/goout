class Study < ActiveRecord::Base
  belongs_to :user
  belongs_to :university
  belongs_to :study_type
  belongs_to :subject_area

  def country_id
  end

end
