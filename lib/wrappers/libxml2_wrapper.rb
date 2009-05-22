require 'xml'

module Tacos

  class LibXML2Wrapper < TacoAbstractWrapper
    attr_accessor :doc

    def all_nodes(query)
      @doc.find(query)
    end

    def create_doc_from_file(file)
      @doc = XML::Parser.string(xml_from_file(file)).parse
    end

    def first_node(query)
      @doc.find_first(query)
    end

    def node_collection(query)
      LibXML2NodeCollection.new(query, self)
    end

  end

end
