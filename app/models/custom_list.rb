class CustomList < ActiveRecord::Base
  belongs_to :contact_list

  def self.import(file)
    formatted_time = Time.now.strftime("%Y-%m-%d--%H:%M:%S")
    contact_list = ContactList.create!(title: "#{formatted_time}-#{file.original_filename}", temp: true)
    xls = open_spreadsheet(file)
    first_col = xls.first_column
    last_row = xls.last_row
    (first_col..last_row).each do |i|
      CustomList.create!(phone: xls.excelx_value(i, first_col), contact_list: contact_list)
    end
    return contact_list
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.xlsx' then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
      # when '.xls' then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
