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

  var _movieListTemplate = ' \
    <% _.each(movies, function(movie, key, list) { %> \
      <tr> \
        <td data-col="title"> \
          <a href="#" data-id="<%= movie[0] %>"><%= movie[1] %></a> \
        </td> \
        <td data-col="release_date"><%= movie[2] %></td> \
        <td data-col="vote_count"><%= movie[3] %></td> \
      </tr> \
    <% }); %>';

  var _movieModalTemplate = ' \
    <% _.each(movie, function(columns, key, list) { %> \
      <% console.log(movie); %> \
      <div id="movie-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"> \
        <div class="modal-dialog modal-lg"> \
          <div class="modal-header"> \
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> \
            <h3><%= columns[10] %></h3> \
          </div> \
          <div class="modal-body"> \
            <div class="left-col"> \
              <img src="http://image.tmdb.org/t/p/w185<%= columns[8] %>" alt="Movie poster"> \
            </div> \
            <div class="right-col"> \
              <p><%= columns[6] %></p> \
              <p><strong>Released:</strong> <%= columns[9] %></p> \
              <p><strong>Original Title:</strong> <%= columns[5] %></p> \
              <p><strong>Original Language:</strong> <%= columns[4] %></p> \
              <p><strong>Popularity:</strong> <%= columns[7] %></p> \
              <p><strong>Votes:</strong> <%= columns[12] %></p> \
              <p><strong>Average Vote:</strong> <%= columns[13] %></p> \
              <p><strong>Video:</strong> <%= columns[11] %></p> \
              <p><strong>Adult:</strong> <%= columns[1] %></p> \
            </div> \
          </div> \
          <div class="modal-footer"> \
            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button> \
          </div> \
        </div> \
      </div> \
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

        _showMovieModal(movie.DATA);
      },
      error: function(xhr, err) {
        console.log('Error in _getMovie: ' + err);
      }
    });
  }

  function _populateTable(movies, $target) { 
    $target.html(_.template(_movieListTemplate, {variable: 'movies'})(movies));
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
    var html = _.template(_movieModalTemplate, {variable: 'movie'})(movie);

    $('#movie-modal').remove();

    $(html).appendTo('.content');

    $('#movie-modal').modal('show'); 
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