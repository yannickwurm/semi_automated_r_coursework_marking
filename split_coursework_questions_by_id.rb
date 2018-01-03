input_file = ARGV[0]
column = ARGV[1].to_i
output_dir = ARGV[2]

require 'fileutils'
require 'csv'

FileUtils.mkdir(output_dir)

CSV.foreach(input_file) do |row|
  row_content = row[column]
  id = row[2]
  next if id == "ID number" # header

  if id.nil?
    puts "No Id for row" + row.join(", ")
    next
  end

                           
  if row_content.length <= 1
    puts "No response for " + id
    next
  end
  
    
  File.open( File.join(output_dir, id + ".R"), 'w') do |output|
    output.write(row_content)
  end                  
end

