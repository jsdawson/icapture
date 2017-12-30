<!--- component with attributes rest and restpath --->
<cfcomponent rest="true" restpath="/api">

  <cfset this.restsettings.autoregister = true />
  <cfset restInitApplication("C:\ColdFusion10\cfusion\wwwroot\restApp", "IIT")>

  <cfset pageSize = 20>

  <cffunction name="getMovies" access="remote" output="false" returntype="string" produces="application/json">

    <cfargument name="page" type="numeric" required="true" default="default value" />
    <cfargument name="sortCol" type="string" required="false" default="release_date" />
    <cfargument name="sort" type="string" required="false" default="desc" />

    <cfif page GT 1>
      <cfset pageOffset = page * pageSize>
    <cfelse>
      <cfset pageOffset = 0>
    </cfif>

    <cfquery name="movieList" datasource="#datasource#">
      SELECT DISTINCT
        id,
        original_title,
        release_date,
        vote_count
      FROM
        movies
      LIMIT
        #pageSize#
      OFFSET
        #pageOffset#
      WHERE
        title LIKE <cfqueryparam value="%#arguments.term#%" cfsqltype="cf_sql_varchar" />
      ORDER BY
        #sortCol# #UCase(sort)#;
    </cfquery>

    <cfreturn serializeJSON(movieList) />

  </cffunction>

</cfcomponent>