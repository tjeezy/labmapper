require 'haml'
require 'date'
require 'json'
require 'parallel'
require 'sinatra' unless defined?(Sinatra)

configure do
  SiteConfig = OpenStruct.new(
    title: 'Labmapper', author: 'TJ Koblentz',
    url_base: 'http://localhost:4567'
  )
  unless $LOAD_PATH.include?(File.dirname(__FILE__) + '/lib')
    $LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
  end
  require 'labmapper'
end
