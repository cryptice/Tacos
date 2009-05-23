module Tacos
  class TacoAbstractWrapper
    def self.new(xml_source=nil, options={})
      instance = super()
      instance.create_doc_from_file(xml_source) if xml_source
      return instance
    end

    def all(query)
      node_collection(query)
    end

    def first(query)
      if source_node = first_node(query)
        node = TNode.new
        node.name = source_node.name
        node.source_node = source_node
        node.taco = self
        node
      end
    end

    def find(selector, options={})
      if selector.is_a?(String)
        first(selector)
      elsif selector.is_a?(Symbol)
        case selector
        when :first
          if options.is_a?(String)
            first(options)
          elsif options.is_a?(Hash)
            raise "Find conditions not implemented yet"
          else
            raise "Invalid find parameters."
          end
        end
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