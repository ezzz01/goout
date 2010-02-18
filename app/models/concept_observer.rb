# This class maintains the state of wiki references for newly created or newly deleted concepts
class ConceptObserver < ActiveRecord::Observer
  
  def after_create(concept)
    WikiReference.update_all("link_type = '#{WikiReference::LINKED_PAGE}'", 
        ['referenced_name = ?', concept.title])
  end

  def before_destroy(concept)
    WikiReference.delete_all ['page_id = ?', concept.id]
    WikiReference.update_all("link_type = '#{WikiReference::WANTED_PAGE}'", 
        ['referenced_name = ?', concept.title])
  end

end
