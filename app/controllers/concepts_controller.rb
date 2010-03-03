class ConceptsController < ApplicationController
  before_filter :load_page
 
  def load_page
    @page_name = params['id'] ? params['id'].purify : nil
   # sekanti eilute reikalinga log'ams
   # @page = @wiki.read_page(@web_name, @page_name) if @page_name
  end

  def index
    list
    if params[:category]
      @category = params[:category]
      @title = t(:all_pages_in_category) + " \"" + @category + "\""
      render :template => 'concepts/list'
    else
      @title = t(:wiki_start_page)
      render :template => 'concepts/first_page'
    end
  end

  def show
    @title = @page_name
    @concept = Concept.find_by_title(@page_name)
    if @concept.nil?
      flash[:notice] = t(:no_such_word)
      redirect_to(concept_url) 
    else 
      @renderer = PageRenderer.new(@concept.revisions.last)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @concept }
      end
    end
  end

  # GET /concepts/new
  # GET /concepts/new.xml
  def new
    @concept = Concept.new
    @concept.title = params[:title] if params[:title]
    @concept.revisions.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @concept }
    end
  end

  # GET /concepts/1/edit
  def edit
    @concept = Concept.find(params[:id])
    @current_revision = (@concept.revisions.empty?)? "" : @concept.revisions.last.content
  end

  # POST /concepts
  # POST /concepts.xml
  def create
    @concept = Concept.new(params[:concept])
    @concept.revisions.last.author = current_user
    @concept.revisions.last.concept = @concept
    renderer = PageRenderer.new
    renderer.revision = @concept.revisions.last
    rendering_result = renderer.render(update_references = true)
    @concept.wiki_references = renderer.update_references(rendering_result)
    respond_to do |format|
      if @concept.save
        flash[:notice] = t(:page_was_successfully_created) 
        format.html { redirect_to(concept_path(@concept.title)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /concepts/1
  # PUT /concepts/1.xml
  def update
    puts "---------------------------"
    @concept = Concept.find(params[:id])
    @updates = params[:concept]
    @updates[:new_revision][:author_id] = current_user.id
    renderer = PageRenderer.new
    revision = Revision.new(@updates[:new_revision])
    revision.concept = @concept
    renderer.revision = revision
    rendering_result = renderer.render(update_references = true)
    wiki_references = renderer.update_references(rendering_result)
    respond_to do |format|
      if @concept.update_attributes(@updates) && @concept.update_attribute("wiki_references", wiki_references) 
        flash[:notice] = t(:page_was_successfully_updated)
        format.html { redirect_to(concept_path(@concept.title)) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /concepts/1
  # DELETE /concepts/1.xml
  def destroy
    @concept = Concept.find(params[:id])
    @concept.destroy
    respond_to do |format|
      format.html { redirect_to(concepts_url) }
    end
  end

  def concept_exists?(name)

  end

  def list
    parse_category
    @page_names_that_are_wanted = @concepts_in_category.wanted_concepts
    @pages_that_are_orphaned = @concepts_in_category.orphaned_concepts
  end

  private

 def parse_category
   @categories = WikiReference.list_categories.sort
   @category = params['category']
   if @category
     @set_name = "category '#{@category}'"
     concepts = WikiReference.concepts_in_category(@category).sort.map { |concept_title| Concept.find_by_title(concept_title) }
     @concepts_in_category = ConceptSet.new(concepts)
   else
     # no category specified, return start page 
     @set_name = t(:wiki_start_page) 
     @concepts_in_category = ConceptSet.new 
   end
  end


end
