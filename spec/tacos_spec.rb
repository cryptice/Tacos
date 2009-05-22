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

    describe "parsing XML from file" do

      it "should return an XML document in to_s" do
        filename = "./spec/mock_xml/books.xml"
        doc = Tacos.new(filename)
        doc.to_s.should eql(File.read(filename).gsub("\"", "'").gsub("\r\n", "\n"))
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

    describe "parsing XML from file" do

      it "should return an XML document in to_s" do
        filename = "./spec/mock_xml/books.xml"
        doc = Tacos.new(filename)
        doc.to_s.should eql(File.read(filename).gsub("\r\n", "\n") + "\n")
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
        end
      end

      it "should return the number of nodes when calling LibXML2NodeCollection#size" #do
        #@doc.all("//book").size.should eql(2)
      #end

    end

    describe "creating an XML document from scratch" do

      #it "should create a root node"

    end

  end
end
