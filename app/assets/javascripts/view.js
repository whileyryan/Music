var View = function() {

};

View.prototype.displayArtistResults = function(data) {
  console.log("display lastfm results");
  var source = $('#artist_template').html();
  var $template = Handlebars.compile(source);

  // for (var i = 0; i < data.length; i++) {
    var context = { image_url: data.images["mega"], mbid: data.mbid, name: data.name, summary: data.summary, content: data.content }
    var html = $template(context)

    $('#artists-container ul').append(html);
  // }

};
