require 'xml'

module Tacos

  class LibXML2Wrapper < TacoAbstractWrapper
    attr_accessor :doc

    def self.new(xml_source=nil, options={})
      instance = super()
      instance.create_doc_from_file(xml_source) if xml_source
      return instance
    end

    def create_doc_from_file(file)
      @doc = XML::Parser.string(xml_from_file(file)).parse
    end

    def xml_from_file(file)
      File.read(file)
    end

    def to_s
      @doc.to_s
    end
  end

end
