
$(document).ready(function(){
    windowScroll();
});




function windowScroll(){
    var nearToBottom = 20;
    var current_concert = 0;
    var current_review = 0;
    var last = 0
    var coordinates = $('.end_concerts').offset();
    $(window).scroll(function(){
        if (($(window).scrollTop() + $(window).height() > $(document).height() - nearToBottom)){
            $.ajax({
                url: '/users/load_concerts',
                dataType: 'JSON',
                type: 'GET', 
                data: {'id': last}
            }).done(function(response){
                console.log(response);
                if (current_concert == response[0]['id']){
                    return;
                };
                $.each(response, function(key, value){
                    var new_concert = "<div class='jambase_concert'>"
                      +"<p>"+value['artist']+"</p>"+
                      "<p>"+value['venue']+"</p>"
                      +"<p>"+value['date']+"</p>"+
                      "<p><a href= "+value['url']+" target='_blank'> Ticket info</a></p>"
                      +"</div>"
                    $('.ajax_concerts').append(new_concert);
                })
                current_concert = (response[0]['id']);
                last = (response[response.length-1]['id']);
            })
            $.ajax({
                url: '/users/load_reviews',
                dataType: 'JSON',
                type: 'GET'
            }).done(function(response){
                if (current_review == response[0]['id']){
                    return;
                };
                $.each(response, function(key, value){
                    console.log(response);
                   var new_review = "<a href='/artists/"+ value['artist']['id']+"'><div class='row'><div class='panel panel-default widget'><div class='panel-heading'><h3 class='panel-title'>"
                + value['artist']['name'] + " at " + value['all']['venue'] + "</h3></div><div class='panel-body'>"+
                "<ul class='list-group'><li class='list-group-item'><div class='row'><div class='review_spacing'>"
                +"<div class='col-xs-10 col-md-11'><div class='reviews_content'> <img src="+value['user']['image']+" class='img-circle img-responsive review_image_userpage'><p>"+ value['all']['content']+"</p></div><div class='mic-info'>"+
                "<div class='col-md-5'>Reviewed By: " + value['user']['name'] + "</div><div class='col-md-5'>Event Date: "+ value['all']['event_date']+"</div><div class='col-md-2'>Rating: "+value['all']['overall_rating']+"</div></div></div></div></div></li></ul></div></div></div></a>"
                $('.ajax_reviews').append(new_review);
                })
                current_review = response[0]['id'];
            })
        }
    })
}



