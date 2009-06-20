module Tacos
  class TacoAbstractWrapper
    def self.new(xml_source=nil, options={})
      instance = super()

      if xml_source

        if xml_source.strip[0..0] == "<"
          instance.create_doc_from_string(xml_source)
        else
          instance.create_doc_from_file(xml_source)
        end
      end
      return instance
    end

    def all(query)
      node_collection(query)
    end

    def create_doc_from_file(file)
      create_doc_from_string(xml_from_file(file))
    end

    def first(query)
      if source_node = first_node(query)
        TNode.new(:source_node => source_node, :taco => self)
      end
    end

    def find(selector, options={})
      if selector.is_a?(String)
        first(selector)
      elsif selector.is_a?(Symbol)
        case selector
        when :all
          if options.is_a?(String)
            all(options)
          elsif options.is_a?(Hash)
            raise "Find conditions not implemented yet"
          else
            raise "Invalid find parameters."
          end
        when :first
          if options.is_a?(String)
            first(options)
          elsif options.is_a?(Hash)
            raise "Find conditions not implemented yet"
          else
            raise "Invalid find parameters."
          end
        else
          raise "Provided quantifier '#{selector.to_s}' is not valid."
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