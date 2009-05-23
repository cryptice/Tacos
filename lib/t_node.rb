module Tacos
  class TNode
    attr_accessor :content, :name, :source_node, :taco

    def self.new(params={})
      tnode = super()
      params.each {|key, value| tnode.send("#{key}=", value)}
      tnode
    end

    def children
      # Maybe solve this with wrapper specifik TNodes
      if @taco.is_a?(LibXML2Wrapper)
        LibXML2NodeCollection.new(source_node.path, @taco)
      elsif @taco.is_a?(REXMLWrapper)
        REXMLNodeCollection.new(source_node.xpath, @taco)
      else
        raise "Invalid Taco wrapper class."
      end
    end

    def name
      source_node.name
    end

    def name=(new_name)
      source_node.name = new_name
    end
  end
end