require "./lib/tacos"

describe "Using tacos" do

  describe "with REXML" do

    before do
      Tacos.library = :rexml
    end
    
    it "should define a REXML taco wrapper" do
      Tacos.new.should be_a(Tacos::TacoAbstractWrapper)
      Tacos.new.should be_a(Tacos::REXMLWrapper)
    end

    describe "creating XML doc from different sources" do

      it "should return an XML document in to_s given a valid XML file (REXML)" do
        filename = "./spec/mock_xml/books.xml"
        Tacos.new(filename).to_s.should eql(File.read(filename).gsub("\"", "'").gsub("\r\n", "\n"))
      end

      it "should return an XML document in to_s given a valid XML string (REXML)" do
        xml_string = File.read "./spec/mock_xml/books.xml"
        Tacos.new(xml_string).to_s.should eql(xml_string.gsub("\"", "'").gsub("\r\n", "\n"))
      end

    end

    describe "using XPath queries" do
      before do
        filename = "./spec/mock_xml/books.xml"
        @doc = Tacos.new(filename)
      end

      it "should find first book node" do
        @doc.first("//book").name.should eql("book")
      end

      it "should find first book node using find" do
        @doc.find("//book").name.should eql("book")
      end

      it "should find first book node using find with explicit :first" do
        @doc.find(:first, "//book").name.should eql("book")
      end

      it "should return nil for a non-existing XPath query" do
        @doc.first("non_existing").should be_nil
      end

      it "should return library nodes when calling #nodes" do
        @doc.all("//book").nodes.should be_a(Array)
      end

      it "should return library nodes when calling #nodes using :all" do
        @doc.find(:all, "//book").nodes.should be_a(Array)
      end

      it "should raise error when calling find with invalid quantifier" do
        lambda {@doc.find(:invalid)}.should raise_error(RuntimeError) { |error|
          error.message.should eql("Provided quantifier 'invalid' is not valid.")
        }
      end

      it "should return a REXMLNodeCollection for lazy evaluation" do
        node_collection = @doc.all("//book")
        node_collection.should be_a(Tacos::AbstractNodeCollection)
        node_collection.should be_a(Tacos::REXMLNodeCollection)
        node_collection.xpath_query.should eql("//book")
      end

      it "should return TNode instances when iterating over a node collection" do
        nodes = @doc.all("//book")
        nodes.each do |node|
          node.should be_a(Tacos::TNode)
          node.name.should eql("book")
          node.source_node.should be_a(REXML::Element)
        end
      end

      it "should return the number of nodes when calling REXMLNodeCollection#size" do
        @doc.all("//book").size.should eql(2)
      end

      it "should return a REXMLNodeCollection containing a nodes children" do
        node = @doc.first("//book")
        node.children.should be_a(Tacos::REXMLNodeCollection)
        node.children.each do |tnode|
          tnode.should be_a(Tacos::TNode)
        end
      end
    end

    describe "creating an XML document from scratch" do

      #it "should create a root node"

    end

  end

  describe "with libxml2" do

    before do
      Tacos.library = :libxml2
    end

    it "should define a LibXML2 taco wrapper" do
      Tacos.new.should be_a(Tacos::TacoAbstractWrapper)
      Tacos.new.should be_a(Tacos::LibXML2Wrapper)
    end

    describe "creating XML doc from different sources" do

      it "should return an XML document in to_s given a valid XML file (LibXML2)" do
        filename = "./spec/mock_xml/books.xml"
        Tacos.new(filename).to_s.should eql(File.read(filename).gsub("\r\n", "\n") + "\n")
      end
      
      it "should return an XML document in to_s given a valid XML string (LibXML2)" do
        xml_string = File.read "./spec/mock_xml/books.xml"
        Tacos.new(xml_string).to_s.should eql(xml_string.gsub("\r\n", "\n") + "\n")
      end

      #it "should return an XML document in to_s given a valid XML IO object (LibXML2)"

    end

    describe "using XPath queries" do
      before do
        filename = "./spec/mock_xml/books.xml"
        @doc = Tacos.new(filename)
      end

      it "should find first book node" do
        @doc.first("//book").name.should eql("book")
      end

      it "should find first book node using find" do
        @doc.find("//book").name.should eql("book")
      end

      it "should find first book node using find with explicit :first" do
        @doc.find(:first, "//book").name.should eql("book")
      end

      it "should return nil for a non-existing XPath query" do
        @doc.first("non_existing").should be_nil
      end

      it "should return library nodes when calling #nodes" do
        @doc.all("//book").nodes.should be_a(LibXML::XML::XPath::Object)
      end

      it "should return a LibXML2NodeCollection for lazy evaluation" do
        node_collection = @doc.all("//book")
        node_collection.should be_a(Tacos::AbstractNodeCollection)
        node_collection.should be_a(Tacos::LibXML2NodeCollection)
        node_collection.xpath_query.should eql("//book")
      end

      it "should return TNode instances when iterating over a node collection" do
        nodes = @doc.all("//book")
        nodes.each do |node|
          node.should be_a(Tacos::TNode)
          node.name.should eql("book")
          node.source_node.should be_a(LibXML::XML::Node)
        end
      end

      it "should return the number of nodes when calling LibXML2NodeCollection#size" do
        @doc.all("//book").size.should eql(2)
      end

      it "should return a LibXML2NodeCollection containing a nodes children" do
        node = @doc.first("//book")
        node.children.should be_a(Tacos::LibXML2NodeCollection)
        node.children.each do |tnode|
          tnode.should be_a(Tacos::TNode)
        end
      end

    end

    describe "creating an XML document from scratch" do

      #it "should create a root node"

    end

  end

  describe "with hpricot" do

    before do
      Tacos.library = :hpricot
    end

    it "should define a Hpricot taco wrapper" do
      Tacos.new.should be_a(Tacos::TacoAbstractWrapper)
      Tacos.new.should be_a(Tacos::HpricotWrapper)
    end

    describe "creating XML doc from different sources" do

      it "should return an XML document in to_s given a valid XML file (Hpricot)" do
        filename = "./spec/mock_xml/books.xml"
        Tacos.new(filename).to_s.should eql(File.read(filename))
      end

      it "should return an XML document in to_s given a valid XML string (Hpricot)" do
        xml_string = File.read "./spec/mock_xml/books.xml"
        Tacos.new(xml_string).to_s.should eql(xml_string)
      end

    end

    describe "using XPath queries" do
      before do
        filename = "./spec/mock_xml/books.xml"
        @doc = Tacos.new(filename)
      end

      it "should find first book node (Hpricot)" do
        @doc.first("//book").name.should eql("book")
      end

      it "should find first book node using find (Hpricot)" do
        @doc.find("//book").name.should eql("book")
      end

      it "should find first book node using find with explicit :first (Hpricot)" do
        @doc.find(:first, "//book").name.should eql("book")
      end

      it "should return nil for a non-existing XPath query (Hpricot)" do
        @doc.first("non_existing").should be_nil
      end

      it "should return library nodes when calling #nodes (Hpricot)" do
        @doc.all("//book").nodes.should be_a(Hpricot::Elements)
      end

      it "should return a HpricotNodeCollection for lazy evaluation" do
        node_collection = @doc.all("//book")
        node_collection.should be_a(Tacos::AbstractNodeCollection)
        node_collection.should be_a(Tacos::HpricotNodeCollection)
        node_collection.xpath_query.should eql("//book")
      end

      it "should return TNode instances when iterating over a node collection (Hpricot)" do
        nodes = @doc.all("//book")
        nodes.each do |node|
          node.should be_a(Tacos::TNode)
          node.name.should eql("book")
          node.source_node.should be_a(Hpricot::Elem)
        end
      end

      it "should return the number of nodes when calling HpricotNodeCollection#size" do
        @doc.all("//book").size.should eql(2)
      end

      it "should return a HpricotNodeCollection containing a nodes children" do
        node = @doc.first("//book")
        node.children.should be_a(Tacos::HpricotNodeCollection)
        node.children.each do |tnode|
          tnode.should be_a(Tacos::TNode)
        end
      end

    end

    describe "creating an XML document from scratch" do

      #it "should create a root node"

    end

  end
end
