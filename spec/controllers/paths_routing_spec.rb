require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PathsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "paths", :action => "index").should == "/paths"
    end
  
    it "should map #new" do
      route_for(:controller => "paths", :action => "new").should == "/paths/new"
    end
  
    it "should map #show" do
      route_for(:controller => "paths", :action => "show", :id => 1).should == "/paths/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "paths", :action => "edit", :id => 1).should == "/paths/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "paths", :action => "update", :id => 1).should == "/paths/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "paths", :action => "destroy", :id => 1).should == "/paths/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/paths").should == {:controller => "paths", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/paths/new").should == {:controller => "paths", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/paths").should == {:controller => "paths", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/paths/1").should == {:controller => "paths", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/paths/1/edit").should == {:controller => "paths", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/paths/1").should == {:controller => "paths", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/paths/1").should == {:controller => "paths", :action => "destroy", :id => "1"}
    end
  end
end
