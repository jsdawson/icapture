<!doctype html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="description" content="iCapture Movie Database">
    <meta name="author" content="SitePoint">
    <title>iCapture - JDawson</title>
    <link rel="stylesheet" href="css/main.css">

    <!--[if lt IE 9]>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.js"></script>
    <![endif]-->
  </head>
  <body>

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
            #movie.id#,
            '#movie.adult#',
            '#movie.backdrop_path#',
            '#SerializeJSON(movie.genre_ids)#',
            '#movie.original_language#',
            '#movie.original_title#',
            '#movie.overview#',
            #movie.popularity#,
            '#movie.poster_path#',
            '#movie.release_date#',
            '#movie.title#',
            '#movie.video#',
            #movie.vote_average#,
            #movie.vote_count#
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

  </body>
</html>
