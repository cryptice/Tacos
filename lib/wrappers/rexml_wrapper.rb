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

    def first(query)
      if source_node = REXML::XPath.first(@doc, query)
        node = TNode.new
        node.name = source_node.name
        node
      end
    end
  end

end
