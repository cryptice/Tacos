module Tacos

  class AbstractNodeCollection
    attr_accessor :xpath_query
    attr_accessor :taco

    def self.new(xpath_query, taco)
      instance = super()
      instance.xpath_query = xpath_query
      instance.taco = taco
      instance
    end

    def each(&block)
      nodes.each do |node|
        yield TNode.new(
          :source_node => node,
          :taco => @taco
        )
      end
    end

    def nodes
      @nodes ||= taco.all_nodes(xpath_query)
    end

    def size
      nodes.size
    end
  end
end