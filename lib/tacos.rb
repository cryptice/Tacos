module Tacos

  require 'lib/wrappers/abstract_wrapper'
  require 'lib/node_collections/abstract_node_collection'
  require 'lib/t_node'

  %w{wrappers node_collections}.each do |dir|
    (Dir.entries("lib/#{dir}") - [".", ".."]).each {|lib| require "lib/#{dir}/#{lib}"}
  end
  
  def self.new(xml_source=nil, options={})
    library_class_name.new(xml_source, options)
  end

  def self.library_class_name
    case @library
    when "rexml", :rexml
      REXMLWrapper
    when "libxml2", :libxml2
      LibXML2Wrapper
    end
  end

  def self.library
    @library
  end

  def self.library=(new_value)
    @library = new_value
  end
end