require 'activerecord'
require 'curb'

puts $0

SHOES_ROOT = "#{File.dirname(__FILE__)}/.." unless defined?(SHOES_ROOT)

Dir["#{SHOES_ROOT}/config/initializers/*"].each do |f|
  require f
end

unless $0 =~ /console/
  Dir["#{SHOES_ROOT}/config/shoes/*"].each do |f|
    require f
  end
end
