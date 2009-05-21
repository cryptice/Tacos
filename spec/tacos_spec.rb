require "./lib/tacos"

describe "Using tacos" do

  describe "with REXML" do

    before do
      Tacos.library = :rexml
    end
    
    describe "parsing XML from file" do

      it "should define a taco wrapper" do
        Tacos.new.should be_a(Tacos::TacoAbstractWrapper)
        Tacos.new.should be_a(Tacos::REXMLWrapper)
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

    describe "parsing XML from file" do

      it "should define a taco wrapper" do
        Tacos.new.should be_a(Tacos::TacoAbstractWrapper)
        Tacos.new.should be_a(Tacos::LibXML2Wrapper)
      end

    end

    describe "creating an XML document from scratch" do

      #it "should create a root node"

    end

  end
end
