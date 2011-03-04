$(function(){
  var
    latlng,
    marker,
    markers = [],
    myOptions = {
      zoom: 10,
      center: new google.maps.LatLng(-34.397, 150.644),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    },
    map = new google.maps.Map(document.getElementById("features_map"), myOptions);

  $.each(features, function(index, feature){
      latlng = new google.maps.LatLng(feature['table']['latitude'], feature['table']['longitude']);

      marker = new google.maps.Marker({
        position: latlng,
        title: feature['table']['name']
      });

      marker.setMap(map);
      markers.push(marker);
  });

  var lats  = $.map(markers, function(marker, index){ return marker.position.lat() }),
      longs = $.map(markers, function(marker, index){ return marker.position.lng() }),
      south_west = new google.maps.LatLng(Array.min(lats), Array.min(longs)),
      north_east = new google.maps.LatLng(Array.max(lats), Array.max(longs)),
      markers_bounds = new google.maps.LatLngBounds(south_west, north_east);

  map.fitBounds(markers_bounds);

});