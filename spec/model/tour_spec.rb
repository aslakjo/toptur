require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tour do
  before(:each) do
    @tour = Tour.new
  end

  describe "paths going up and down" do
    it "should return the same climb path when pathGoingUp is called" do
      @tour.pointsGoingUp=("[[61.96426900653652,7.189178466796875],[61.96830297186323,7.2344970703125],[61.96717351533785,7.247200012207031]]")
    
      @tour.pointsGoingUp.should == "[[61.9642690065365,7.18917846679688],[61.9683029718632,7.2344970703125],[61.9671735153378,7.24720001220703],[]]"
    end

    it "should return the same down path when pathGoingDown is called" do
      @tour.pointsGoingDown=("[[61.96426900653652,7.189178466796875],[61.96830297186323,7.2344970703125],[61.96717351533785,7.247200012207031]]")

      @tour.pointsGoingDown.should == "[[61.9642690065365,7.18917846679688],[61.9683029718632,7.2344970703125],[61.9671735153378,7.24720001220703],[]]"
    end
  end
end

