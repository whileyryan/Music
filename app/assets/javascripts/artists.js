$(function(){
  $('a.youtube').YouTubeModal({autoplay: true});
  $('#triggerautocomplete').on('click', function(){
    $('#autocomplete').geocomplete()
    })
})



