class OrganizationsController < ApplicationController


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
      elsif(params[:organization_type] == "company")
        @organization = Company.new(params[:organization])
      elsif(params[:organization_type] == "ngo")
        @organization = Ngo.new(params[:organization])
      end
	@organization.added_by = session[:user_id]
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
#       format.xml  { render :xml => @organization, :status => :created, :location => @organization}
      else
        format.html { render :action => "new" }
        format.js { 
            render :update do |page|
                page << "alert(' #{t(:error_saving_organization)}');"
                page << "lightbox.prototype.deactivate();"
                flash.discard
            end
        }
#       format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        flash[:notice] = 'Organization was successfully updated.'
        format.html { redirect_to(@organization) }
#       format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
#       format.xml  { render :xml => @university.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to(organizations_url) }
#     format.xml  { head :ok }
    end
  end
end
