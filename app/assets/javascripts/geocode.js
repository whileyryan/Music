
$(document).ready(function(){
	initialize();
});
var map;
var geocoder;

function initialize() {

  // Try HTML5 geolocation
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = new google.maps.LatLng(position.coords.latitude,
                                       position.coords.longitude);
      var latitude = pos['k']
      var longitude = pos['B']
  geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(latitude,longitude);

  geocoder.geocode({'latLng': latlng}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var zipcode = (results[3]['address_components'][0]['long_name']);
      storeZipCode(zipcode);
    } 
  });

    });
  }
}

function storeZipCode(zipcode){
  $.ajax({
    url: '/store_zipcode/'+zipcode,
    type: 'post'
  }).done(function(response){
    console.log(response);
  })
}


