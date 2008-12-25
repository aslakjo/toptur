# To change this template, choose Tools | Templates
# and open the template in the editor.
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ToursController do
  before(:each) do
    @tour_controller = ToursController.new
  end

  it "should give all" do
    @tour_controller.all
  end
end

