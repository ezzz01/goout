class ExchangeProgramsController < ConceptsController 
  load_and_authorize_resource

  def index
    @exchange_programs = ExchangeProgram.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exchange_programs }
    end
  end

  # GET /exchange_programs/1
  # GET /exchange_programs/1.xml
  def show
    @exchange_program = ExchangeProgram.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exchange_program }
    end
  end

  # GET /exchange_programs/new
  # GET /exchange_programs/new.xml
  def new
    @exchange_program = ExchangeProgram.new

    respond_to do |format|
      format.html # new.html.erb
      format.js { render :partial => 'remote_form', :layout => 'modal' }
    # format.xml  { render :xml => @exchange_program }
    end
  end

  def edit
    @exchange_program = ExchangeProgram.find(params[:id])
  end

  def create
    @exchange_program = ExchangeProgram.new(params[:exchange_program])
	@exchange_program.added_by = current_user.id
    new_revision = Revision.new(:content=> "category: Mainų programos", :author_id => current_user.id, :concept => @exchange_program)
    @exchange_program.revisions << new_revision
    respond_to do |format|
      if @exchange_program.save
        flash[:notice] = 'ExchangeProgram was successfully created.'
        format.html { redirect_to(@exchange_program) }
        exchange_programs = ExchangeProgram.find(:all, :order => :title)
        format.js {
            render :update do |page|
                page.replace_html 'exchange_program', :partial => 'activities/exchange_programs', :locals => {},  :object => exchange_programs 
                page[:activity_exchange_program_id].set_style :width => "400px"
                page << "lightbox.prototype.deactivate();"
                page << "initialize();" 
                flash.discard
            end
        }
      else
        format.html { render :action => "new" }
        format.js { 
            render :update do |page|
                page << "alert(' #{t(:error_saving_exchange_program)}');"
                page << "lightbox.prototype.deactivate();"
                flash.discard
            end
        }
      end
    end
  end

  def update
    @exchange_program = ExchangeProgram.find(params[:id])
    super()
  end

  # DELETE /exchange_programs/1
  # DELETE /exchange_programs/1.xml
  def destroy
    @exchange_program = ExchangeProgram.find(params[:id])
    @exchange_program.destroy

    respond_to do |format|
      format.html { redirect_to(exchange_programs_url) }
      format.xml  { head :ok }
    end
  end
end
