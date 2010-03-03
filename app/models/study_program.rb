class StudyProgram < Concept 
    belongs_to :subject_area
    has_many :full_studies
    has_many :exchange_studies
    validates_presence_of :subject_area_id 
    validates_uniqueness_of :title
end
