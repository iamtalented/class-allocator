class Phase1 < ActiveRecord::Base
  
  require 'csv'
  require 'roo'
  
  require 'simple-spreadsheet'
  
  default_scope -> {order(created_at: :desc)}
  
  def self.import(file)
    spreadsheet = User.open_spreadsheet(file)
    header = spreadsheet.row(11)
    (13..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      product.attributes = row.to_hash.slice(*accessible_attributes)
      product.save!
    end
  end
  
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, packed: nil, file_warning: :ignore)
    when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
  
  def accessible_attributes
    [:name, :nric, :school, :class_name, :email, :phone, :choice_1, :choice_2, :choice_3, :choice_4, :choice_5]
  end

end
