require 'xml'

module Tacos

  class LibXML2Wrapper < TacoAbstractWrapper
    attr_accessor :doc

    def create_doc_from_file(file)
      @doc = XML::Parser.string(xml_from_file(file)).parse
    end

    def first_node(query)
      @doc.find_first(query)
    end
  end

end
