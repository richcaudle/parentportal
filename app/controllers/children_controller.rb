class ChildrenController < ApplicationController

  # GET /children  
  def index
    @areas = LearningArea.all
    @children = Child.my_children(session[:user_id])
      .includes(:entries).where("entries.deleted" => false)
  end

  # GET /children/1
  def show

    if Child.can_access_child(session[:user_id], params[:id])
      
      @entries = Entry.where(:child_id => params[:id]).where(:deleted => false).order("created_at DESC")
      @child = Child.find(params[:id])
      @entry_types = EntryType.all
      @class = SchoolClass.find(@child.class_id)
      @areas = LearningArea.all

    else
      redirect_to home_url, notice: 'You do not have permission to access that page'
    end
    
  end

  # GET /children/new
  def new
    @child = Child.new
    @classes = SchoolClass.my_classes(session[:user_id])
  end

  # GET /children/1/edit
  def edit
    @classes = SchoolClass.my_classes(session[:user_id])
    @child = Child.find(params[:id])
  end

  # POST /children
  def create
    @child = Child.new(params[:child])
    @classes = SchoolClass.my_classes(session[:user_id])
    @child.deleted = false

    if @child.save
      redirect_to @child, notice: 'Child was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /children/1
  def update
    @child = Child.find(params[:id])
    @classes = SchoolClass.my_classes(session[:user_id])

    if @child.update_attributes(params[:child])
      redirect_to @child, notice: 'Child was successfully updated.'
    else
      render action: "edit"
    end
    
  end

  # DELETE /children/1
  def destroy
    @child = Child.find(params[:id])
    @child.deleted = true
    @child.save

    redirect_to children_url
  end

  # GET /children/1/journal
  def journal

    if Child.can_access_child(session[:user_id], params[:child_id])
      @entries = Entry.where(:child_id => params[:child_id]).where(:deleted => false).order("created_at DESC")
      @child = Child.find(params[:child_id])
      @entry_types = EntryType.all
      @areas = LearningArea.all
    else
      redirect_to home_url, notice: 'You do not have permission to access that page'
    end
    
  end

  def profile_photo
    @child = Child.find(params[:child_id])
  end

  def profile_photo_action
    @child = Child.find(params[:child_id])
    error = nil

    if @child.save
      redirect_to @child
    else
      render action: "profile_photo"
    end
    
  end

end
