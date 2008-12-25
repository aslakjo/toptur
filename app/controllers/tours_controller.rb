
class ToursController < ApplicationController
  # GET /tours
  # GET /tours.xml
  @@up_color = "#0000FF"
  @@down_color = "#ff0000"

  def index
    @tours = Tour.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tours }
    end
  end

  # GET /tours/1
  # GET /tours/1.xml
  def show
    @map = constructMapController

    @tour = Tour.find(params[:id])
    @map.record_init "registerField(g('tour_pointsGoingUp'), EditMode.climb);"
    @map.record_init "registerField(g('tour_pointsGoingDown'), EditMode.down);"
    
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tour }
    end
  end

  # GET /tours/new
  # GET /tours/new.xml
  def new
    @map = constructMapController
    @tour = Tour.new


    @map.record_init "registerField(g('tour_pointsGoingUp'), EditMode.climb);"
    @map.record_init "registerField(g('tour_pointsGoingDown'), EditMode.down);"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tour }
    end
  end

  # GET /tours/1/edit
  def edit
    @map = constructMapController


    @map.record_init "registerField(g('tour_pointsGoingUp'), EditMode.climb);"
    @map.record_init "registerField(g('tour_pointsGoingDown'), EditMode.down);"
    @tour = Tour.find(params[:id])
    
    
  end

  # POST /tours
  # POST /tours.xml
  def create
    @tour = Tour.new(params[:tour])

    respond_to do |format|
      if @tour.save
        flash[:notice] = 'Tour was successfully created.'
        format.html { redirect_to(@tour) }
        format.xml  { render :xml => @tour, :status => :created, :location => @tour }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tours/1
  # PUT /tours/1.xml
  def update
    @tour = Tour.find(params[:id])

    respond_to do |format|
      if @tour.update_attributes(params[:tour])
        flash[:notice] = 'Tour was successfully updated.'
        format.html { redirect_to(@tour) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tour.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.xml
  def destroy
    @tour = Tour.find(params[:id])
    @tour.destroy

    respond_to do |format|
      format.html { redirect_to(tours_url) }
      format.xml  { head :ok }
    end
  end

  def all
    @map = constructMapController
    @tours = Tour.find :all

    @tours.each do |tour|
      @map.overlay_init(GMarker.new(tour.upPath.to_array.last, :title => tour.title))
      @map.overlay_init(GPolyline.new(tour.upPath.to_array, @@up_color, 2, 100))
      @map.overlay_init(GPolyline.new(tour.downPath.to_array, @@down_color, 2, 100))
    end
  end

  private

  def constructMapController
    @map = GMap.new "map_div"
    @map.control_init :large_map => true, :map_type => true
    @map.center_zoom_init([61.971505561437446, 7.2461700439453125],12)
    @map.set_map_type_init(Variable.new("G_PHYSICAL_MAP"))

    @map.record_init "map.enableScrollWheelZoom();"


    @map.event_init @map, :click, "click_handler"

    @map.record_init "initializeMapHandler(map);"

    return @map
  end

  
end
