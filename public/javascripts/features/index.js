$(function(){
  var
    latlng,
    marker,
    myOptions = {
      zoom: 10,
      center: new google.maps.LatLng(-34.397, 150.644),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    },
    map = new google.maps.Map(document.getElementById("features_map"), myOptions);

  $.each(features, function(index, feature){
      latlng = new google.maps.LatLng(feature['latitude'], feature['longitude']);

      marker = new google.maps.Marker({
        position: latlng,
        title: feature['title']
      });

      marker.setMap(map);
  });

});