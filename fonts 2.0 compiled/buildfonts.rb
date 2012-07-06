Dir["*/build.hxml"].each do |build_file|
  file = File.absolute_path build_file
  puts "Changing to directory #{File.dirname(file)}"
  Dir.chdir(File.dirname(file))
  begin
    system("haxe build.hxml")
  rescue
    puts "Error building #{File.dirname build_file}"
  ensure
    Dir.chdir("../")
  end
end