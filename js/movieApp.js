// ================================================================================================
// Movie Module
// ================================================================================================

var movieApp = movieApp || (function(window, $) {  

  // ----------------------------------------------------------------------------------------------
  //   Private Members
  // ----------------------------------------------------------------------------------------------
  var _apiBaseUrl = 'http://candidate-test.icapture.com/dawsonj/api.cfc';
  var _sortCol = 'vote_count';
  var _sortOrder = 'DESC';

  var _movieTemplate = ' \
    <% _.each(movies, function(movie, key, list) { %> \
      <tr> \
        <td data-col="original_title"> \
          <a href="#" data-id="<%= movie[0] %>"><%= movie[1] %></a> \
        </td> \
        <td data-col="release_date"><%= movie[2] %></td> \
        <td data-col="vote_count"><%= movie[3] %></td> \
      </tr> \
    <% }); %>';

  function _bindEvents() {
    $('thead').on('click', 'th a', function() {
      var $link = $(this);
      var column = $link.data('col');

      _sortTable(column);
    });

    $('tbody').on('click', 'td a', function() {
      var $link = $(this);
      var id = $link.data('id');

      _getMovie(id);
    });
  }

  function _getMovies(page, sortCol, sortOrder) {
    var result;

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
        var movies = JSON.parse(data);

        _populateTable(movies.DATA, $('#movies tbody'));
      },
      error: function(xhr, err) {
        console.log('Error in _getMovies: ' + err);
      }
    });
  }

  function _getMovie(id) {
    var result;

    $.ajax({
      url : _apiBaseUrl,
      type: 'get',
      data: { 
        method : 'getMovie',
        id     : id
      },
      success: function(data, status) {
        var movie = JSON.parse(data);

        _showMovieModal(movie);
      },
      error: function(xhr, err) {
        console.log('Error in _getMovie: ' + err);
      }
    });
  }

  function _populateTable(movies, $target) { 
    $target.html(_.template(_movieTemplate, {variable: 'movies'})(movies));
  }

  function _sortTable(sortCol) {
    var ascending = 'ASC';
    var descending = 'DESC';
    var prevSortCol = _sortCol;
    var prevSortOrder = _sortOrder;

    if (sortCol === prevSortCol) {
      _sortOrder = (prevSortOrder === ascending) ? descending : ascending;
    } else {
      _sortOrder = ascending;
    }

    _sortCol = sortCol;

    _getMovies(1, _sortCol, _sortOrder);
  }

  function _showMovieModal(movie) {
    console.log(movie);
  }

  // ----------------------------------------------------------------------------------------------
  //   Public Members
  // ----------------------------------------------------------------------------------------------
  var init = function() {
    _bindEvents();
    _getMovies(1, _sortCol, _sortOrder);
  }

  // ----------------------------------------------------------------------------------------------
  //   Public Interface
  // ----------------------------------------------------------------------------------------------
  return {
    init : init
  }
})(window, jQuery);