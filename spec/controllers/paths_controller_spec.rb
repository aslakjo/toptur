require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PathsController do

  def mock_path(stubs={})
    @mock_path ||= mock_model(Path, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all paths as @paths" do
      Path.should_receive(:find).with(:all).and_return([mock_path])
      get :index
      assigns[:paths].should == [mock_path]
    end

    describe "with mime type of xml" do
  
      it "should render all paths as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Path.should_receive(:find).with(:all).and_return(paths = mock("Array of Paths"))
        paths.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested path as @path" do
      Path.should_receive(:find).with("37").and_return(mock_path)
      get :show, :id => "37"
      assigns[:path].should equal(mock_path)
    end
    
    describe "with mime type of xml" do

      it "should render the requested path as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Path.should_receive(:find).with("37").and_return(mock_path)
        mock_path.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new path as @path" do
      Path.should_receive(:new).and_return(mock_path)
      get :new
      assigns[:path].should equal(mock_path)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested path as @path" do
      Path.should_receive(:find).with("37").and_return(mock_path)
      get :edit, :id => "37"
      assigns[:path].should equal(mock_path)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created path as @path" do
        Path.should_receive(:new).with({'these' => 'params'}).and_return(mock_path(:save => true))
        post :create, :path => {:these => 'params'}
        assigns(:path).should equal(mock_path)
      end

      it "should redirect to the created path" do
        Path.stub!(:new).and_return(mock_path(:save => true))
        post :create, :path => {}
        response.should redirect_to(path_url(mock_path))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved path as @path" do
        Path.stub!(:new).with({'these' => 'params'}).and_return(mock_path(:save => false))
        post :create, :path => {:these => 'params'}
        assigns(:path).should equal(mock_path)
      end

      it "should re-render the 'new' template" do
        Path.stub!(:new).and_return(mock_path(:save => false))
        post :create, :path => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested path" do
        Path.should_receive(:find).with("37").and_return(mock_path)
        mock_path.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :path => {:these => 'params'}
      end

      it "should expose the requested path as @path" do
        Path.stub!(:find).and_return(mock_path(:update_attributes => true))
        put :update, :id => "1"
        assigns(:path).should equal(mock_path)
      end

      it "should redirect to the path" do
        Path.stub!(:find).and_return(mock_path(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(path_url(mock_path))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested path" do
        Path.should_receive(:find).with("37").and_return(mock_path)
        mock_path.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :path => {:these => 'params'}
      end

      it "should expose the path as @path" do
        Path.stub!(:find).and_return(mock_path(:update_attributes => false))
        put :update, :id => "1"
        assigns(:path).should equal(mock_path)
      end

      it "should re-render the 'edit' template" do
        Path.stub!(:find).and_return(mock_path(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested path" do
      Path.should_receive(:find).with("37").and_return(mock_path)
      mock_path.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the paths list" do
      Path.stub!(:find).and_return(mock_path(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(paths_url)
    end

  end

end
