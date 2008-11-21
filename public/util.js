
var currentRoute = new Route();
var EditMode = { down:0, climb:1 };
var routePolyline = null;
var currentMode = null;

var up = null;
var down = null;

function initializeMapHandler(referenceToMap){
    currentRoute.onAddPoint = updateMap;
};

function updateMap(points, lastPoint){
    if(points.length > 1){
        try{
            if(routePolyline != null)
                map.removeOverlay(routePolyline);
        }catch(e){
            console.debug(e)
        }

        routePolyline = constructPolyline(points);
        
        map.addOverlay(routePolyline);
    }
};

function constructPolyline(points){
    line = new GPolyline(points);
    line.geodesic = true;

    return line;
}

function map_click(latlng){
    console.log("map_click ", currentRoute.points);
    currentRoute.addPoint(latlng);

    if(currentRoute.points.length == 1)
        map.addOverlay(new GMarker(latlng));
};

function overlay_click(overlay, latlng){
    console.log("overlay_click", overlay, latlng);
};

function g(id){
    return document.getElementById(id);
}

function saveCurrentRoute(mode){
    if(mode == EditMode.climb)
        g("up").innerHTML = currentRoute.toJSON();
    else if(mode == EditMode.down)
        g("down").innerHTML = currentRoute.toJSON();


};



function Route(){
    this.points = [];
    this.onAddPoint = null;

    this.addPoint = function(latlng){
        this.points = this.points.concat(latlng);
        
        if(this.onAddPoint != null){
            this.onAddPoint(this.points, latlng)
        }
    };

    this.isEmpty=function(){
        return this.points.length > 0;
    };

    this.toJSON = function(){
        jsonString = "[";
        first = true;
        for(index in this.points){
            if(!first){
                jsonString += ","
            }

            point = this.points[index]
            jsonString += "[" + point.lat() +","+ point.lng() +"]";
            first = false;
        }
        jsonString += "]"
        return jsonString;
    };
};

var setMode = function(mode){
    if(currentMode != null){
        saveCurrentRoute(currentMode);
    }
    currentMode = mode;
    currentRoute = new Route();
    currentRoute.onAddPoint = updateMap;
    if(mode == EditMode.climb){
        console.debug("climbing mode");

    }else if(mode == EditMode.down){
        console.debug("skiing mode");
    }

}


var click_handler=function(overlay, latlng, overlay_latlng){
    if(latlng != null)
    {
        map_click(latlng);
    }else if(overlay != null && overlay_latlng != null)
    {
        overlay_click(overlay, overlay_latlng);
    }

};



