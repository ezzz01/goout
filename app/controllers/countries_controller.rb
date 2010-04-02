class CountriesController < ConceptsController 
  load_and_authorize_resource
  def index
    @countries = Country.all(:order => :title)
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @country = Country.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @country = Country.new

    respond_to do |format|
      format.html # new.html.erb
      format.js { render :partial => 'remote_form', :layout => 'modal' }
    end
  end

  def edit
    @country = Country.find(params[:id])
  end

  def create
    @country = Country.new(params[:country])
	@country.added_by = current_user.id
    new_revision = Revision.new(:content=> "category: Šalys", :author_id => current_user.id, :concept => @country)
    @country.revisions << new_revision
    respond_to do |format|
      if @country.save
        flash[:notice] = 'Country was successfully created.'
        format.html { redirect_to(@country) }
        format.js {
            render :update do |page|
                page.replace_html 'country', :partial => 'activities/countries',  :object => Country.all(:order => :title)
#               page[:activity_country_id].set_style :width => "400px"
                page << "lightbox.prototype.deactivate();"
                page << "initialize();" 
                flash.discard
            end
        }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @country = Country.find(params[:id])
    super()
  end

  def destroy
    @country = Country.find(params[:id])
    @country.destroy
    respond_to do |format|
      format.html { redirect_to(countries_url) }
    end
  end
end
