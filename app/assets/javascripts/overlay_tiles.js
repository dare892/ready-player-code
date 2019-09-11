function displayTiles(){
  $('#overlay-tiles').removeClass('hidden');
  for(var t=1;t<101;t++){
    setTimeout(function(){
      $('#overlay-tiles').addC("<div class='overlay-tile'></div>")
      $('.overlay-tile[data-tile-id='+t+']').addClass('visible')
    }, t*20)
  }
  setTimeout(function(){
    $('#overlay-tiles').fadeOut();
    $('.overlay-tile').removeClass('visible')
  }, 2500)
}
