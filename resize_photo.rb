# encoding: UTF-8

$start_folder = "D:/abc/"
$convert_size = "2048x2048"

def recursive_folder(folder)
  puts "== cd #{File.realpath(folder)} =="
  Dir.chdir(folder)
  Dir.foreach('.') do |file|
    check_file_type(file)
  end
  Dir.chdir('..')
end

def check_file_type(file)
  return if file == '.' or file == '..' or file == '.AppleDouble'
  if File.directory?(file)
    recursive_folder(file)
  elsif ["gif", "jpg", "jpeg", "png"].include?(File.extname(file).downcase[1..-1])
    convert_file_name = File.basename(file, File.extname(file)) + "_small" + File.extname(file)
    puts "== convert #{file}  to #{convert_file_name}  #{$convert_size} =="
    system("convert  #{file} -resize #{$convert_size}  #{convert_file_name}")
  end
  File.extname(file)
end

Dir.chdir($start_folder)
Dir.foreach($start_folder) do |file|
  check_file_type(file)
end
