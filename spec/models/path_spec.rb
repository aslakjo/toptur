require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Path do
  before(:each) do
    @point1 = Point.create(:lat => "10.0", :lng => "60.0")
    @point2 = Point.create(:lat => "10.0", :lng => "60.0")

    @valid_attributes = {
      :name=>"up",
      :points => [@point1, @point2]
    }
  end

  it "should create a new instance given valid attributes" do
    Path.create!(@valid_attributes)
  end

  describe "to_array" do
    before :each do
      @path = Path.create!(@valid_attributes)
    end

    it "should produce correct array on to_array" do
      @path.to_array.should_not be_empty
      @path.to_array.length.should == 2
    end

    it "should produce empty array when appropriate" do
      @valid_attributes[:points] = []
      @path = Path.create!(@valid_attributes)

      @path.to_array.should be_empty
    end


  end


end
