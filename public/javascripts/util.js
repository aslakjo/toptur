
var currentRoute = new Route();
var routes = []
var EditMode = {
    down:0,
    climb:1
};

var currentMode = null;

function initializeMapHandler(){
    currentRoute.onAddPoint = updateMap;
};

function registerField(field, mode){
    if(mode == EditMode.down){
        workingRoute =  new Route(field.value)
        colorCode= downColor
    }else
    {
        workingRoute = new Route(field.value)
        colorCode = upColor
    }

    routes[mode] = workingRoute

    map.addOverlay(constructPolyline(workingRoute.points, colorCode))
}


function updateMap(points){
    routePolyline = routes[currentMode]
    if(points.length > 1){
        if(routePolyline != null)
        {
            map.removeOverlay(routePolyline);
        }
        
        routePolyline = constructPolyline(points, modeColor(currentMode));
        
        map.addOverlay(routePolyline);
    }
};

function modeColor(mode){
    if(mode == EditMode.down)
        return downColor;
    else if(mode == EditMode.climb)
        return upColor;
    else
        return "#ffffff";

};

function constructPolyline(points, color){
    constructPolyline(points, "#ffffff")
}

function constructPolyline(points, colorCode){
    line = new GPolyline(points, colorCode ,2, 100)
    line.geodesic = true;



    return line;
}

function map_click(latlng){
    currentRoute.addPoint(latlng);

    if(currentRoute.points.length == 1)
        map.addOverlay(new GMarker(latlng));
};

function overlay_click(overlay, latlng){
;
};

function g(id){
    return document.getElementById(id);
}

function f(name){
    return document.getElementsByName(name);
}

function saveCurrentRoute(mode){
    if(mode == EditMode.climb)
    {
        g("tour_pointsGoingUp").value = currentRoute.toJSON();
        map.removeOverlay(routes[mode])
        routes[mode] = currentRoute
    }
    else if(mode == EditMode.down)
    {
        g("tour_pointsGoingDown").value = currentRoute.toJSON();
        map.removeOverlay(routes[mode])
        routes[mode] = currentRoute
    }

    updateMap(routes[mode])
};

function fetchRoute(mode){
    if(routes[mode] == null)
        routes[mode] = new Route();

    return routes[mode];
}

function setMode(new_mode){
    if(currentMode != null){
        saveCurrentRoute(currentMode);
    }
    routes[currentMode] = currentRoute

    currentMode = new_mode;

    currentRoute =  fetchRoute(new_mode);
    currentRoute.clear()
    currentRoute.onAddPoint = updateMap;

    resetMap()
}


function resetMap(){
    map.clearOverlays();

    map.addOverlay(constructPolyline(routes[EditMode.down].points, downColor))
    map.addOverlay(constructPolyline(routes[EditMode.climb].points, upColor))
}



function click_handler(overlay, latlng, overlay_latlng){
    if(latlng != null)
    {
        map_click(latlng);
    }else if(overlay != null && overlay_latlng != null)
    {
        overlay_click(overlay, overlay_latlng);
    }

};

function Route(fromJson){
    this.points = []
    if(fromJson != undefined){
        pointsArray = eval(fromJson)
        for(pointIndex in pointsArray){
            point = pointsArray[pointIndex]
            if(point.length == 2){
                this.points = this.points.concat(new GLatLng(point[0], point[1]))
            }
        }
    }

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

    this.clear=function(){
        this.points = [];
        if(this.onAddPoint != null){
            this.onAddPoint(this.points)
        }
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