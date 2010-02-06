class Concept < ActiveRecord::Base
  has_many :revisions, :dependent => :destroy
  validates_presence_of :title
  validates_uniqueness_of :title

 def new_revision=(revision_attributes)
   revisions.build(revision_attributes)
 end


end
