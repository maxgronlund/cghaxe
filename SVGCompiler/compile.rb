require 'fileutils'
swfmill = "/usr/local/bin/swfmill"

Dir["svg/*.svg"].each do |svg_dir|
  svg_filename = File.basename(svg_dir)
  name = svg_filename.dup
  name['.svg'] = ''
  name = name.downcase
  
  xml_filename = "#{name}.xml"
  swf_filename = "#{name}.swf"
  
  puts "Creating #{name.capitalize}...."
  
  File.open(xml_filename, "w") do |file|
    file << '<?xml version="1.0" encoding="iso-8859-1"?>'
    file << \
<<-XML
  <movie version="9" width="800" height="900" framerate="30"> 
  	<frame> 

  		<library>
  			<clip id="#{name.capitalize}" import="svg/#{svg_filename}" />
  		</library> 
  	</frame> 
  </movie>
XML
  
  end
  
  puts "Created #{xml_filename}."
  
  if system("#{swfmill} simple #{xml_filename} #{swf_filename}")
    FileUtils.mv("#{xml_filename}", "xml/#{xml_filename}")
    FileUtils.mv("#{swf_filename}", "swf/#{swf_filename}")
    puts "Created #{swf_filename}."
  else
    puts "Failed to create #{swf_filename}." 
  end

end

puts "Done."