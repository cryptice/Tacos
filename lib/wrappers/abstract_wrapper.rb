module Tacos
  class TacoAbstractWrapper
    def self.new(xml_source=nil, options={})
      instance = super()
      instance.create_doc_from_file(xml_source) if xml_source
      return instance
    end

    def first(query)
      if source_node = first_node(query)
        node = TNode.new
        node.name = source_node.name
        node
      end
    end

    def xml_from_file(file)
      File.read(file)
    end

    def to_s
      @doc.to_s
    end
  end
end