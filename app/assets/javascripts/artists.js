// $(document).ready(function() {


//   $('#toggleyoutube').on('click', function(){
//     $('a.youtube').YouTubeModal({autoplay: true});
//   })


// $('#autocomplete').on('focus', function(){
//     $('#autocomplete').geocomplete()
//     })




// })

var ready;
ready = function() {
  $('#toggleyoutube').on('click', function(){
    $('a.youtube').YouTubeModal({autoplay: true});
  })


  $('#autocomplete').on('focus', function(){
      $('#autocomplete').geocomplete()
      })
};

$(document).ready(ready);
$(document).on('page:load', ready);
