require 'fileutils'
require 'date'

regex = /eval(.*?)\)\)\;/

files = []
File.read("lists.txt").each_line do |line|
  files << line.chop
end


files.each do |file_name|
  check = File.join("**", "#{file_name}")
  l = Dir.glob(check)
  i = l.join("")
  text = File.read(i)
  if text =~ regex
    mod = text.gsub(regex, '')
    name = File.basename(file_name)
    now = Date.today
    backup_date = now.strftime("%b%-d")
    FileUtils.cp i, "#{i}.backup-#{backup_date}.php.txt"
    File.open(i, 'w') { |file| file.write(mod) }
    puts "modified #{i}"
  end
end