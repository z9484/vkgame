COPYRIGHT_FILE = 'doc/copyright.txt'
desc "Add the gpl header to all the ruby files."
task :gpl do
  header_head = `head -n 3 #{COPYRIGHT_FILE}`
  header_contents = File.read COPYRIGHT_FILE
  Dir['**/*.rb'].each do |file|
    unless `head -n 3 #{file}` == header_head
      contents = File.read(file)
      File.open(file, 'w') {|f| f << header_contents << contents}
    end
  end
end

desc "Remove the ugly gpl headers cluttering up the code."
task :ungpl do
  header_head = `head -n 3 #{COPYRIGHT_FILE}`
  Dir['**/*.rb'].each do |file|
    if `head -n 3 #{file}` == header_head
      contents = File.readlines(file)
      until contents.shift =~ /COPYING/ do; nil; end
      contents.shift if contents.first.chomp.empty?
      File.open(file, 'w') do |f|
        f << contents.join
      end
    end
  end
end
