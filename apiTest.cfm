<!doctype html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="description" content="The HTML5 Herald">
    <meta name="author" content="SitePoint">
    <title>iCapture - JDawson</title>
    <link rel="stylesheet" href="css/main.css">

    <!--[if lt IE 9]>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.js"></script>
    <![endif]-->
  </head>
  <body>

    <cfset apiTestUrl = apiBaseUrl & "/3/movie/550" & apiKey>

    <cfhttp
      url="#apiTestUrl#"
      method="get"
      result="apiResult">
    </cfhttp>

    <cfset json = DeserializeJSON(apiResult.filecontent)>

    <cfdump var="#json#">
  </body>
</html>
