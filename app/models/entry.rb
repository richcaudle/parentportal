class Entry < ActiveRecord::Base
  belongs_to :entry_type

  attr_accessible :child_id, :deleted, :entry_type_id, :image, :order, :text

  validates :entry_type_id, :presence => true
  validates_format_of :image, :with => /\.(jpeg|jpg|png)$/i, :allow_nil => true, :message => "Please choose a PNG or JPG file"

  def self.save_image child_id, entry_id, image
    file_name = 'entry_' + entry_id.to_s + File.extname(image.original_filename)
    path = Rails.root.join('public', 'uploads', 'children', child_id.to_s, file_name)
    dir = File.dirname(path)

    unless File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end

    File.open(path, 'w') do |file|
      file.syswrite(image.read)
    end

    return "/uploads/children/#{child_id}/#{file_name}"

  end

  def self.temp_save_image child_id, image
    file_name = 'entry_temp' + File.extname(image.original_filename)
    path = Rails.root.join('public', 'uploads', 'children', child_id.to_s, file_name)
    dir = File.dirname(path)

    unless File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end

    File.open(path, 'w') do |file|
      file.syswrite(image.read)
    end

    return File.extname(image.original_filename)

  end

  def self.temp_rename_image child_id, entry_id, extension
    curr_file_name = 'entry_temp' + extension
    curr_path = Rails.root.join('public', 'uploads', 'children', child_id.to_s, curr_file_name)
    
    new_file_name = 'entry_' + entry_id.to_s + extension
    new_path = Rails.root.join('public', 'uploads', 'children', child_id.to_s, new_file_name)

    File.rename(curr_path, new_path)

    return "/uploads/children/#{child_id}/#{new_file_name}"

  end

end
