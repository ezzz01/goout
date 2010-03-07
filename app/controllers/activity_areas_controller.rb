class ActivityAreasController < ConceptsController 
  # GET /activity_areas
  # GET /activity_areas.xml
  def index
    @activity_areas = ActivityArea.all

    respond_to do |format|
      format.html # index.html.erb
    #  format.xml  { render :xml => @activity_areas }
    end
  end

  # GET /activity_areas/1
  # GET /activity_areas/1.xml
  def show
    @activity_area = ActivityArea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    #  format.xml  { render :xml => @activity_area }
    end
  end

  # GET /activity_areas/new
  # GET /activity_areas/new.xml
  def new
    @activity_area = ActivityArea.new
    respond_to do |format|
      format.html # new.html.erb
      format.js { render :partial => 'remote_form', :layout => 'modal' }
    #  format.xml  { render :xml => @activity_area }
    end
  end

  # GET /activity_areas/1/edit
  def edit
    @activity_area = ActivityArea.find(params[:id])
  end

  # POST /activity_areas
  # POST /activity_areas.xml
  def create
    @activity_area = ActivityArea.new(params[:activity_area])
    @activity_area.added_by = current_user.id
    new_revision = Revision.new(:content=> "category: Veiklos sritys", :author_id => current_user.id, :concept => @activity_area)
    @activity_area.revisions << new_revision
    respond_to do |format|
      if @activity_area.save
        flash[:notice] = 'ActivityArea was successfully created.'
        format.html { redirect_to(@activity_area) }
        format.js {
          activity_areas = ActivityArea.find(:all, :order => :title)
            render :update do |page|
                page.replace_html 'activity_area', :partial => 'activities/activity_areas', :locals => {},  :object => activity_areas 
                page[:activity_activity_area_id].set_style :width => "400px"
                page << "lightbox.prototype.deactivate();"
                page << "initialize();" 
                flash.discard
            end
        }
      else
        format.html { render :action => "new" }
        format.js { 
            render :update do |page|
                page << "alert(' #{t(:error_saving_activity_area)}');"
                page << "lightbox.prototype.deactivate();"
                flash.discard
            end
        }
      end
    end
  end

  # PUT /activity_areas/1
  # PUT /activity_areas/1.xml
  def update
    @activity_area = ActivityArea.find(params[:id])
    super()
  end

  # DELETE /activity_areas/1
  # DELETE /activity_areas/1.xml
  def destroy
    @activity_area = ActivityArea.find(params[:id])
    @activity_area.destroy

    respond_to do |format|
      format.html { redirect_to(activity_areas_url) }
    #  format.xml  { head :ok }
    end
  end
end
