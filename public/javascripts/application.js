// Put your application scripts here
(function heightSorter() {
  windowH = $(window).height();
  docH = $(document).height();
  if ( docH == windowH ) {

    numberOfBuilds = $('article').size();
    newSize = (windowH / numberOfBuilds) - 20;
    $('article').height(newSize);
    $('ul').addClass("resizedList");
  }
})()

function colourPulser() {
  $('.blue_anime').animate({opacity: 0.4}, 400 ).animate({opacity: 1}, 370 );
  $('.aborted_anime').animate({opacity: 0.4}, 400 ).animate({opacity: 1}, 370 );
  $('.red_anime').animate({opacity: 0.4}, 400 ).animate({opacity: 1}, 370 );
}

setTimeout('colourPulser()', 1000);
setTimeout('location.reload()', 30000);