$(document).ready(function(){
    var i = 0;
    var nearToBottom = 20;
    console.log($('.ajax_concerts'));
    var coordinates = $('.end_concerts').offset();
    $(window).scroll(function(){
        if (($(window).scrollTop() + $(window).height() > $(document).height() - nearToBottom) && (i < 1)){
            i++
            console.log(i);
            $.ajax({
                url: '/users/load_concerts',
                dataType: 'JSON',
                type: 'GET', 
                data: {'id': last}
            }).done(function(response){
                console.log(response);
                $.each(response, function(key, value){
                    var new_concert = "<div class='jambase_concert'>"
                      +"<p>"+value['artist']+"</p>"+
                      "<p>"+value['venue']+"</p>"
                      +"<p>"+value['date']+"</p>"+
                      "<p><a href= "+value['url']+" target='_blank'> Ticket info</a></p>"
                      +"</div>"
                    $('.ajax_concerts').append(new_concert);
                })
                last = (response[response.length-1]['id']);
            })
        }
        i = 0
    })
    $.ajax({
        url: '/users/original',
        dataType: 'JSON',
        type: 'GET'
    }).done(function(response){
        last = (response[response.length-1]['id']);
        $.each(response, function(key, value){
            var new_concert = "<div class='jambase_concert'>"
              +"<p>"+value['artist']+"</p>"+
              "<p>"+value['venue']+"</p>"
              +"<p>"+value['date']+"</p>"+
              "<p><a href= "+value['url']+" target='_blank'> Ticket info</a></p>"
                +"</div>"
            $('.ajax_concerts').append(new_concert);
        })
    })
});