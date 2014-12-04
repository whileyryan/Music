$(document).ready(function() {


  $('#toggleyoutube').on('click', function(){
    $('a.youtube').YouTubeModal({autoplay: true});
  })


$('#autocomplete').on('focus', function(){
    $('#autocomplete').geocomplete()
    })




})


