class EntriesController < ApplicationController
  
  # GET /entries
  def index
    @child = Child.find(params[:child_id])
    @entries = Entry.where(:child_id => params[:child_id])
  end

  # GET /entries/1
  def show
    @entry = Entry.find(params[:id])

    if @entry.deleted
      redirect_to home_url, notice: 'You do not have permission to access that page'
    end

  end

  # GET /entries/new
  def new
    @entry = Entry.new
    @child = Child.find(params[:child_id])
    @entry_types = EntryType.all
    @entry_type_id = Integer(params[:entry_type_id])
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
    @child = Child.find(params[:child_id])
    @entry_types = EntryType.all
    @entry_type_id = @entry.entry_type_id
  end

  # POST /entries
  def create
    
    @entry = Entry.new(params[:entry])
    @entry.child_id = params[:child_id]
    @entry.deleted = false
    @entry_types = EntryType.all
    @entry_type_id = Integer(params[:entry_type_id])
    @child = Child.find(params[:child_id])

    if params[:entry][:image] 
      extension = Entry.temp_save_image(@child.id, params[:entry][:image])
      @entry.image = params[:entry][:image].original_filename
      params[:entry].delete('image')
    else
      @entry.image = nil
    end

    @entry.entry_type_id = @entry_type_id

    if @entry.save

      if extension
        @entry.image = Entry.temp_rename_image(@child.id, @entry.id, extension)
        @entry.save
      end

      puts 'Here'
      redirect_to @child, notice: 'Entry was successfully added.'
    else
      render action: "new"
    end

  end

  # PUT /entries/1
  def update
    @entry = Entry.find(params[:id])
    @entry_types = EntryType.all
    @child = Child.find(params[:child_id])
    @entry_type_id = Integer(params[:entry_type_id])

    if params[:entry][:image] 
      picture_path = Entry.save_image(@child.id, @entry.id, params[:entry][:image])
      @entry.image = picture_path
      params[:entry].delete('image')
    else
      @entry.image = nil
    end

    if @entry.update_attributes(params[:entry])
      redirect_to @child, notice: 'Entry was successfully updated.'
    else
      render action: "edit"
    end
    
  end

  # DELETE /entries/1
  def destroy
    @entry = Entry.find(params[:id])
    @entry.deleted = true
    @entry.save

    @child = Child.find(params[:child_id])

    redirect_to @child, notice: 'Entry was successfully deleted.'
  end

end
