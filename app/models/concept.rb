class Concept < ActiveRecord::Base
  has_many :revisions, :dependent => :destroy
  validates_presence_of :title

 def new_revision_attributes=(revision_attributes)
   revisions.build(revision_attributes)
 end


end
