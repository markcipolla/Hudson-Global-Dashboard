// Hudson Global Dashboard
// created by Mark Cipolla

Hudson = (function(){
  var response
  
  
  var fetch = function(hudsonBuild) {
    response = $.ajax({ 
      url: "/fetch/" + hudsonBuild, 
      context: document.body, 
      success: successfulResponse
    });
  }
  
  var successfulResponse = function() {
    alert("Woo!")
  }
  
}());


