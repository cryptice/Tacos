require 'hpricot'

module Tacos

  class HpricotWrapper < TacoAbstractWrapper
    attr_accessor :doc

    def all_nodes(query)
      @doc.search(query)
    end

    def create_doc_from_string(string)
      @doc = Hpricot.XML(string)
    end

    def first_node(query)
      @doc.at(query)
    end

    def node_collection(query)
      HpricotNodeCollection.new(query, self)
    end

  end

end
