<!--- =============================================================================================
  Movie databas API
============================================================================================= --->

<cfcomponent output="false">
  <cfset this.restsettings.autoregister = true />

  <!--- -------------------------------------------------------------------------------------------
    Returns a list of movies

    Example invocation:
    http://candidate-test.icapture.com/dawsonj/api.cfc?method=getMovies&page=1&sortCol=vote_count&sort=asc
  ------------------------------------------------------------------------------------------- --->
  <cffunction name="getMovies" access="remote" returnType="string" returnFormat="json" output="false">

    <cfargument name="page" type="numeric" required="false" default="1" />
    <cfargument name="sortCol" type="string" required="false" default="vote_count" />
    <cfargument name="sort" type="string" required="false" default="desc" />

    <cfset pageSize = 20>

    <cfif page GT 1>
      <cfset pageOffset = page * pageSize>
    <cfelse>
      <cfset pageOffset = 0>
    </cfif>

    <cfquery name="movieList" datasource="candidate_dawsonj">
      SELECT
        id,
        title,
        DATE_FORMAT(release_date, '%b %d %Y'),
        vote_count
      FROM
        movies
      ORDER BY
        #sortCol# #UCase(sort)#
      LIMIT
        #pageSize#
      OFFSET
        #pageOffset#;
    </cfquery>

    <cfreturn serializeJSON(movieList) />

  </cffunction>

  <!--- -------------------------------------------------------------------------------------------
    Returns a all fields for the [id] movie

    Example invocation:
    http://candidate-test.icapture.com/dawsonj/api.cfc?method=getMovie&id=335409
  ------------------------------------------------------------------------------------------- --->
  <cffunction name="getMovie" access="remote" returnType="string" returnFormat="json" output="false">

    <cfargument name="id" type="numeric" required="true" />

    <cfquery name="movie" datasource="candidate_dawsonj">
      SELECT
        id,
        adult,
        backdrop_path,
        genre_ids,
        original_language,
        original_title,
        overview,
        popularity,
        poster_path,
        DATE_FORMAT(release_date, '%b %d %Y'),
        title,
        video,
        vote_average,
        vote_count
      FROM
        movies
      WHERE
        id = #id#;
    </cfquery>

    <cfreturn serializeJSON(movie) />

  </cffunction>

</cfcomponent>