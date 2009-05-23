module Tacos

  class REXMLNodeCollection < AbstractNodeCollection

    def each(&block)
      nodes.each do |node|
        yield TNode.new(
          :source_node => node,
          :taco => @taco
        )
      end
    end

  end
end