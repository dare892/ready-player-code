function displayTiles(){
  if($('#overlay-tiles').length < 1){
    $('body').append("<div id='overlay-titles'></div>")
    for(var t=0;t<200;t++){
      $('#overlay-tiles').append("<div class='overlay-title'></div>")
    }
    setTimeout(function(){
      $('#overlay-tiles').fadeOut();
    }, 3000)
    setTimeout(function(){
      $('#overlay-tiles').remove();
    }, 4000)
  }
}
