require 'rexml/document'

module Tacos

  class REXMLWrapper < TacoAbstractWrapper
    attr_accessor :doc

    def create_doc_from_file(file)
      @doc = REXML::Document.new(xml_from_file(file))
    end

    def first_node(query)
      REXML::XPath.first(@doc, query)
    end
  end

end
