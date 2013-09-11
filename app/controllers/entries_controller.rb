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
    @areas = LearningArea.all
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
    @child = Child.find(params[:child_id])
    @entry_types = EntryType.all
    @entry_type_id = @entry.entry_type_id
    @areas = LearningArea.all
  end

  # POST /entries
  def create
    
    area_params = params[:entry][:areas].clone
    params[:entry].delete("areas")

    @entry = Entry.new(params[:entry])
    @entry.child_id = params[:child_id]
    @entry.deleted = false
    @entry_type_id = Integer(params[:entry_type_id])

    @child = Child.find(params[:child_id])
    @entry_types = EntryType.all
    @areas = LearningArea.all

    @entry.entry_type_id = @entry_type_id
    
    if @entry.save
      process_areas @areas, @entry, area_params
      redirect_to @child, notice: 'Entry was successfully added.'
    else
      render action: "new"
    end

  end

  # PUT /entries/1
  def update
    @entry = Entry.find(params[:id])
    @entry_types = EntryType.all
    @areas = LearningArea.all
    @child = Child.find(params[:child_id])
    @entry_type_id = Integer(params[:entry_type_id])

    if params[:entry][:image] 
      picture_path = Entry.save_image(@child.id, @entry.id, params[:entry][:image])
      @entry.image = picture_path
      params[:entry].delete('image')
    else
      @entry.image = nil
    end

    process_areas @areas, @entry, params[:entry][:areas]
    params[:entry].delete('areas')

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

  private

    def process_areas(areas, entry, params)
      
      if entry.learning_areas.length > 0
        entry.learning_areas.destroy_all
      end

      areas.each do |area|
        if params["#{area.id}"]
          entry.entry_learning_areas.create(learning_area: area)
        end
      end

    end

end
