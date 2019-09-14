function overlay_in(){
  $('#transition-overlay').css({'opacity':'0.3', "display":'block'})
}

function overlay_out(){
  $('#transition-overlay').css({'opacity':'0'})
  setTimeout(function(){
    $('#transition-overlay').css({'display':'none'})
    $('#generic-progress-wrapper').addClass('hidden')
    $('#generic-progress').stop().css("width","0")
  }, 200);
}
