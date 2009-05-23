module Tacos

  class REXMLNodeCollection < AbstractNodeCollection

    def each(&block)
      nodes.each do |node|
        tnode = TNode.new
        tnode.name = node.name
        tnode.source_node = node
        yield tnode
      end
    end

  end
end