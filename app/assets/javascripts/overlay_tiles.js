function displayTiles(){
  $('.overlay-tile').fadeIn();
  $('#overlay-tiles').removeClass('hidden');
  var k = 1;
  for(var t=0;t<100;t++){
    setTimeout(function(){
      $('.overlay-tile[data-tile-id='+k+']').addClass('visible')
      k++;
    }, t*10)
  }
  setTimeout(function(){
    $('.overlay-tile').fadeOut();
  }, 2000)
  setTimeout(function(){
    $('#overlay-tiles').addClass('hidden');
    $('.overlay-tile').removeClass('visible')
  }, 2500)
}
