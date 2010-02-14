class ConceptsController < ApplicationController
  before_filter :load_page
 
  def load_page
    @page_name = params['id'] ? params['id'].purify : nil
   # sekanti eilute reikalinga log'ams
   # @page = @wiki.read_page(@web_name, @page_name) if @page_name
  end

  def index
    @concepts = Concept.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
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
    @concept.revisions.first.author = current_user
    respond_to do |format|
      if @concept.save
        flash[:notice] = 'Concept was successfully created.'
        format.html { redirect_to(concept_path(@concept.title)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /concepts/1
  # PUT /concepts/1.xml
  def update
    @concept = Concept.find(params[:id])
    @updates = params[:concept]
    @updates[:new_revision][:author_id] = current_user.id
    respond_to do |format|
      if @concept.update_attributes(@updates)
        flash[:notice] = 'Concept was successfully updated.'
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

end
