class SchoolClassesController < ApplicationController
  
  # GET /school_classes
  def index
    @school_classes = SchoolClass.all
  end

  # GET /school_classes/1
  def show
    @school_class = SchoolClass.find(params[:id])
  end

  # GET /school_classes/new
  def new
    @school_class = SchoolClass.new
  end

  # GET /school_classes/1/edit
  def edit
    @school_class = SchoolClass.find(params[:id])
  end

  # POST /school_classes
  def create
    @school_class = SchoolClass.new(params[:school_class])

    if @school_class.save
      redirect_to @school_class, notice: 'School class was successfully created.'
    else
      render action: "new"
    end

  end

  # PUT /school_classes/1
  def update
    @school_class = SchoolClass.find(params[:id])

    
    if @school_class.update_attributes(params[:school_class])
      redirect_to @school_class, notice: 'School class was successfully updated.'
    else
      render action: "edit"
    end
    
  end

  # DELETE /school_classes/1
  def destroy
    @school_class = SchoolClass.find(params[:id])
    @school_class.destroy

    redirect_to school_classes_url
  end
end
