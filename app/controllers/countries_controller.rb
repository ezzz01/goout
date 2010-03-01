class CountriesController < ApplicationController
  # GET /countries
  def index
    @countries = Country.all(:order => :title)
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /countries/1
  def show
    @country = Country.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /countries/new
  def new
    @country = Country.new

    respond_to do |format|
      format.html # new.html.erb
      format.js { render :partial => 'remote_form', :layout => 'modal' }
    end
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  # POST /countries
  def create
    @country = Country.new(params[:country])
	@country.added_by = session[:user_id]
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

  # PUT /countries/1
  def update
    @country = Country.find(params[:id])
    respond_to do |format|
      if @country.update_attributes(params[:country])
        flash[:notice] = 'Country was successfully updated.'
        format.html { redirect_to(@country) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /countries/1
  def destroy
    @country = Country.find(params[:id])
    @country.destroy
    respond_to do |format|
      format.html { redirect_to(countries_url) }
    end
  end
end
