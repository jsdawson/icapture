<!doctype html>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="description" content="iCapture Movie Database">
    <meta name="author" content="John Dawson">

    <title>iCapture - JDawson</title>
    
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

        <cfset page = 2>
        <cfset apiTestUrl = apiBaseUrl & "/3/discover/movie" & apiKey & "&language=en-US&sort_by=popularity.desc&certification=R&include_adult=false&include_video=false&page=" & page & "&primary_release_year=2015&with_genres=878">

        <cfhttp
          url="#apiTestUrl#"
          method="get"
          result="apiResult">
        </cfhttp>

        <cfset json = DeserializeJSON(apiResult.filecontent)>

        <cfdump var="#json#">

      </div>

    </div>
    <footer>

      <small>Copyright &copy; <time datetime="2017">2017</time></small>

    </footer>
  </body>
</html>
