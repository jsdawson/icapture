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

    <cfset page = 2>
    <cfset apiTestUrl = apiBaseUrl & "/3/discover/movie" & apiKey & "&language=en-US&sort_by=popularity.desc&certification=R&include_adult=false&include_video=false&page=" & page & "&primary_release_year=2015&with_genres=878">

    <cfhttp
      url="#apiTestUrl#"
      method="get"
      result="apiResult">
    </cfhttp>

    <cfset json = DeserializeJSON(apiResult.filecontent)>

    <cfdump var="#json#">
  </body>
</html>
