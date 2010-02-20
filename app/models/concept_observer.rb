# This class maintains the state of wiki references for newly created or newly deleted concepts
class ConceptObserver < ActiveRecord::Observer
  
  def after_create(concept)
    WikiReference.update_all("link_type = '#{WikiReference::LINKED_PAGE}'", 
        ['referenced_name = ?', concept.title])
  end

  def after_update(concept)
    #cia yra bugas
    WikiReference.delete_all ['concept_id = ?', concept.id]
    WikiReference.update_all("link_type = '#{WikiReference::LINKED_PAGE}'", 
        ['referenced_name = ?', concept.title])
  end

  def before_destroy(concept)
    WikiReference.delete_all ['concept_id = ?', concept.id]
    WikiReference.update_all("link_type = '#{WikiReference::WANTED_PAGE}'", 
        ['referenced_name = ?', concept.title])
  end

end
