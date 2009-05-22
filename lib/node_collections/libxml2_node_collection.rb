module Tacos

  class LibXML2NodeCollection < AbstractNodeCollection

    def each(&block)
      nodes.each do |node|
        tnode = TNode.new
        tnode.name = node.name
        yield tnode
      end
    end

  end
end