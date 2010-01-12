class ExchangeProgramsController < ApplicationController
  # GET /exchange_programs
  # GET /exchange_programs.xml
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
      format.xml  { render :xml => @exchange_program }
    end
  end

  # GET /exchange_programs/1/edit
  def edit
    @exchange_program = ExchangeProgram.find(params[:id])
  end

  # POST /exchange_programs
  # POST /exchange_programs.xml
  def create
    @exchange_program = ExchangeProgram.new(params[:exchange_program])

    respond_to do |format|
      if @exchange_program.save
        flash[:notice] = 'ExchangeProgram was successfully created.'
        format.html { redirect_to(@exchange_program) }
        format.xml  { render :xml => @exchange_program, :status => :created, :location => @exchange_program }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exchange_program.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exchange_programs/1
  # PUT /exchange_programs/1.xml
  def update
    @exchange_program = ExchangeProgram.find(params[:id])

    respond_to do |format|
      if @exchange_program.update_attributes(params[:exchange_program])
        flash[:notice] = 'ExchangeProgram was successfully updated.'
        format.html { redirect_to(@exchange_program) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exchange_program.errors, :status => :unprocessable_entity }
      end
    end
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
