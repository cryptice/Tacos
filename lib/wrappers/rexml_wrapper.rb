require 'rexml/document'

module Tacos

  class REXMLWrapper < TacoAbstractWrapper
    attr_accessor :doc

    def all_nodes(query)
      REXML::XPath.match(@doc, query)
    end

    def create_doc_from_file(file)
      @doc = REXML::Document.new(xml_from_file(file))
    end

    def first_node(query)
      REXML::XPath.first(@doc, query)
    end

    def node_collection(query)
      REXMLNodeCollection.new(query, self)
    end
  end

end
