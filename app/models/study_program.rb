class StudyProgram < ActiveRecord::Base
    belongs_to :subject_area

    validates_presence_of :subject_area_id 
    validates_uniqueness_of :title
end
