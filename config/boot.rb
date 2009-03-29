require 'activerecord'
require 'curb'

SHOES_ROOT = "#{File.dirname(__FILE__)}/.." unless defined?(SHOES_ROOT)

[
  'config/initializers/*',
  'app/models/*',
].each do |path|
  Dir["#{SHOES_ROOT}/#{path}"].each do |file|
    require file
  end
end

if $0 =~ /irb/
  ActiveRecord::Base.establish_connection({
    :adapter => 'sqlite3',
    :dbfile => SOLO_PATH,
  })
else
  [
    'config/shoes/*',
    'app/views/*',
  ].each do |path|
    Dir["#{SHOES_ROOT}/#{path}"].each do |file|
      require file
    end
  end
end
