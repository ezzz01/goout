class OrganizationsController < ConceptsController 
  load_and_authorize_resource

  def index
    @organizations = Organization.all

    respond_to do |format|
      format.html # index.html.erb
#     format.xml  { render :xml => @organizations}
    end
  end

  def show
    @organization = Organization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
#     format.xml  { render :xml => @organization}
    end
  end

  def new
    @organization = Organization.new
    respond_to do |format|
      format.html 
      format.js { render :partial => 'remote_form', :layout => 'modal' }
#     format.xml  { render :xml => @organization}
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def create
      if(params[:organization_type] == "university")
        @organization = University.new(params[:organization])
        new_revision = Revision.new(:content=> "category: Universitetai", :author_id => current_user.id, :concept => @organization)
      elsif(params[:organization_type] == "company")
        @organization = Company.new(params[:organization])
        new_revision = Revision.new(:content=> "category: Įmonės", :author_id => current_user.id, :concept => @organization)
      elsif(params[:organization_type] == "ngo")
        @organization = Ngo.new(params[:organization])
        new_revision = Revision.new(:content=> "category: Nevyriausybinės organizacijos", :author_id => current_user.id, :concept => @organization)
      end
	@organization.added_by = current_user.id 
    @organization.revisions << new_revision
    respond_to do |format|
      if @organization.save
        flash[:notice] = 'Organization was successfully created.'
        format.html { redirect_to(@organization) }
        format.js {
            orgs = load_organizations(params[:organization][:country_id]) 
            render :update do |page|
                page.replace_html 'organization', :partial => 'activities/organizations', :locals => {:id => params[:organization][:country_id] }, :object=> orgs
                page[:activity_organization_id].set_style :width => "400px"
                page << "lightbox.prototype.deactivate();"
                page << "initialize();" 
                flash.discard
            end
        }
      else
        format.html { render :action => "new" }
        format.js { 
            render :update do |page|
                page << "alert(' #{t(:error_saving_organization)}');"
                page << "lightbox.prototype.deactivate();"
                flash.discard
            end
        }
      end
    end
  end

  def update
    super()
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to(organizations_url) }
    end
  end
end
