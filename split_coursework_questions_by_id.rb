input_file = ARGV[0]
column = ARGV[1].to_i
output_dir = ARGV[2]

require 'fileutils'
require 'csv'

FileUtils.mkdir(output_dir)

CSV.foreach(input_file) do |row|
  row_content = row[column]
  id = row[3]
  next if id == "student_id" # header

  if id.nil?
    puts "No Id for row" + row.join(", ")
    next
  end

                           
  if row_content.length <= 1
    puts "No response for " + id
    next
  end
  
  student_dir = File.join(output_dir, id)
  FileUtils.mkdir_p(student_dir)
  File.open( File.join(student_dir, "code.R"), 'w') do |output|
    output.write(row_content)
  end                  
end

