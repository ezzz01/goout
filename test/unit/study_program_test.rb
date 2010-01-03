require 'test_helper'

class StudyProgramTest < ActiveSupport::TestCase
fixtures :study_programs

  def setup
    @valid_study_program = study_programs(:one)
    @invalid_study_program = study_programs(:two) 
  end

    def test_should_have_subject_area 
        study_program = StudyProgram.new
        assert !study_program.save, "Saved the Study program without a subject area"
    end
   
    def test_should_save_sub_area
        study_program = @valid_study_program
        assert study_program.save
    end

    def test_should_not_save_duplicate_sub_area
        study_program = StudyProgram.find(1)
        study_program2 = StudyProgram.new(:title => @valid_study_program.title, :subject_area_id => @valid_study_program.subject_area_id)
        assert !study_program2.save, "Saved duplicated study program"
    end


end
