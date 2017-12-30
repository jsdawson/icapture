// ================================================================================================
// Movie Module
// ================================================================================================

var movieApp = movieApp || (function(window, $) {  

  // ----------------------------------------------------------------------------------------------
  //   Private Members
  // ----------------------------------------------------------------------------------------------
  var _apiBaseUrl = 'http://candidate-test.icapture.com/dawsonj/api.cfc';

  var _bindEvents = function() {

  }

  // ----------------------------------------------------------------------------------------------
  //   Public Members
  // ----------------------------------------------------------------------------------------------
  var init = function() {
    _bindEvents();
  }

  var getMovies = function(page, sortCol, sortOrder) {
    $.ajax({
      url : _apiBaseUrl,
      type: 'get',
      data: { 
        method : 'getMovies',
        page   : page,
        sortCol: sortCol,
        sort   : sortOrder
      },
      success: function(data, status) {
        console.log(data);
      },
      error: function(xhr, err) {
        console.log('Error in getMovies: ' + err);
      }
    });
  }

  // ----------------------------------------------------------------------------------------------
  //   Public Interface
  // ----------------------------------------------------------------------------------------------
  return {
    init      : init,
    getMovies : getMovies
  }
})(window, jQuery);