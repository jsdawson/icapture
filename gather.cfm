<!doctype html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="description" content="iCapture Movie Database">
    <meta name="author" content="John Dawson">

    <title>iCapture - JDawson</title>
    
    <link rel="icon" type="image/png" href="http://candidate-test.icapture.com/dawsonj/img/icon.png">
    <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css">

    <!--[if lt IE 9]>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.js"></script>
    <![endif]-->

    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="js/movieApp.js"></script>
    <script src="js/main.js"></script>
  </head>
  <body>
    <div class="content">

      <div class="content-inside">

        <header>
          <h1>My Movie Database</h1>
        </header>

        <cfquery name="truncateTable" datasource="#datasource#">
          TRUNCATE TABLE movies
        </cfquery>

        <cfloop from="1" to="5" index="page">

          <cfset apiUrl = apiBaseUrl & "/3/discover/movie" & apiKey & "&language=en-US&sort_by=popularity.desc&certification=R&include_adult=false&include_video=false&page=" & page & "&primary_release_year=2015&with_genres=878">

          <cfhttp
            url="#apiUrl#"
            method="get"
            result="apiResult">
          </cfhttp>

          <cfset json = DeserializeJSON(apiResult.filecontent)>

          <cfloop array=#json.results# index="movie">

            <cfif not isDefined("movie.backdrop_path")>
              <cfset movie.backdrop_path="">
            </cfif>

            <cfquery name="dbInsert" datasource="#datasource#">
              INSERT INTO
                movies (
                  id,
                  adult,
                  backdrop_path,
                  genre_ids,
                  original_language,
                  original_title,
                  overview,
                  popularity,
                  poster_path,
                  release_date,
                  title,
                  video,
                  vote_average,
                  vote_count
                )
              VALUES (
                <cfqueryparam value="#movie.id#"                       cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#movie.adult#"                    cfsqltype="cf_sql_nvarchar">,
                <cfqueryparam value="#movie.backdrop_path#"            cfsqltype="cf_sql_nvarchar">,
                <cfqueryparam value="#SerializeJSON(movie.genre_ids)#" cfsqltype="cf_sql_nvarchar">,
                <cfqueryparam value="#movie.original_language#"        cfsqltype="cf_sql_nvarchar">,
                <cfqueryparam value="#movie.original_title#"           cfsqltype="cf_sql_nvarchar">,
                <cfqueryparam value="#movie.overview#"                 cfsqltype="cf_sql_nvarchar">,
                <cfqueryparam value="#movie.popularity#"               cfsqltype="cf_sql_decimal">,
                <cfqueryparam value="#movie.poster_path#"              cfsqltype="cf_sql_nvarchar">,
                <cfqueryparam value="#movie.release_date#"             cfsqltype="cf_sql_date">,
                <cfqueryparam value="#movie.title#"                    cfsqltype="cf_sql_nvarchar">,
                <cfqueryparam value="#movie.video#"                    cfsqltype="cf_sql_nvarchar">,
                <cfqueryparam value="#movie.vote_average#"             cfsqltype="cf_sql_decimal">,
                <cfqueryparam value="#movie.vote_count#"               cfsqltype="cf_sql_integer">
              );
            </cfquery>

          </cfloop>

        </cfloop>

        <cfquery name="allMovies" datasource="#datasource#">
          SELECT
            *
          FROM
            movies;
        </cfquery>

        <cfdump var="#allMovies#">

      </div>

    </div>
    <footer>

      <small>Copyright &copy; <time datetime="2017">2017</time></small>

    </footer>
  </body>
</html>
