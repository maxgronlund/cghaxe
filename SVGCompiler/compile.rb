require 'fileutils'
require 'erubis'
swfmill = "/usr/local/bin/swfmill"

input = File.read('./build.hxml.eruby')
$build_file = Erubis::Eruby.new(input)

xml_input = File.read('./library.xml.eruby')
$library_xml_file = Erubis::Eruby.new(xml_input)


puts "---------------------"
puts "Compiling libraries!"
puts "---------------------\n\n"

Dir["svg/*.svg"].each do |svg_dir|
  svg_filename = File.basename(svg_dir)
  name = svg_filename.dup
  name['.svg'] = ''
  name = name.downcase
  
  xml_filename = "#{name}.xml"
  swf_filename = "#{name}_library.swf"
  final_swf_filename = "#{name}.swf"
  build_file_name = "build_#{name}.hxml"
  
  puts "Creating #{name.capitalize}...."


  File.open(xml_filename, "w") do |file|
    file << $library_xml_file.result(name: name.capitalize, svg_filename: svg_filename)  
  end  
  puts "Created #{xml_filename}..."
  
  
  if system("#{swfmill} simple #{xml_filename} #{swf_filename}")
    FileUtils.mv("#{xml_filename}", "xml/#{xml_filename}")
    FileUtils.mv("#{swf_filename}", "assets/#{swf_filename}")
    puts "Created #{swf_filename}..."
    
    
    File.open(build_file_name, "w") do |build_file|
      build_file << $build_file.result(name: name)
    end
    
    if system("haxe #{build_file_name}")
      FileUtils.mv("#{build_file_name}", "build_files/#{build_file_name}")
      puts "Created #{final_swf_filename}..."
    else
      puts "Error creating #{final_swf_filename}"
    end
    
    puts "\n#{name} done."
    puts "\n---------------------------------"
    
  else
    puts "Error creating #{swf_filename}" 
  end

end # of each svg_dir

puts "\nDone."