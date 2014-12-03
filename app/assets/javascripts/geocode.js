  
$(document).ready(function(){
	runDisShit();
});
var map;
var geocoder;

function runDisShit() {

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
      var zipcode = (results[0]['address_components'][7]['long_name']);
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


