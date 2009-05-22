require 'rexml/document'

module Tacos

  class REXMLWrapper < TacoAbstractWrapper
    attr_accessor :doc

    def self.new(xml_source=nil, options={})
      instance = super()
      instance.create_doc_from_file(xml_source) if xml_source
      return instance
    end

    def create_doc_from_file(file)
      @doc = REXML::Document.new(xml_from_file(file))
    end

    def xml_from_file(file)
      File.read(file)
    end

    def to_s
      @doc.to_s
    end
  end

end
