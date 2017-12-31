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

        <cfquery name="dbDrop" datasource="#datasource#">
          DROP TABLE movies;
        </cfquery>

        <cfquery name="dbCreate" datasource="#datasource#">
          CREATE TABLE
            `movies` (
              `id` int(11) NOT NULL PRIMARY KEY,
              `adult` varchar(10) DEFAULT NULL,
              `backdrop_path` varchar(100) DEFAULT NULL,
              `genre_ids` text,
              `original_language` varchar(20) DEFAULT NULL,
              `original_title` varchar(100) CHARSET UTF8 DEFAULT NULL,
              `overview` text,
              `popularity` decimal(10,6) DEFAULT NULL,
              `poster_path` varchar(100) DEFAULT NULL,
              `release_date` datetime DEFAULT NULL,
              `title` varchar(100) DEFAULT NULL,
              `video` varchar(10) DEFAULT NULL,
              `vote_average` decimal(4,2) DEFAULT NULL,
              `vote_count` int(11) DEFAULT NULL
            ) CHARACTER SET=utf8;
        </cfquery>

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
            101,
            'adult',
            'backdrop_path',
            'genre_ids',
            'original_language',
            'original_title',
            'overview',
            10,
            'poster_path',
            CURRENT_DATE(),
            'title',
            'video',
            20,
            30
          );
        </cfquery>

        <cfquery name="dbVerify" datasource="#datasource#">
          SELECT
            *
          FROM
            movies;
        </cfquery>

        <cfdump var="#dbVerify#">

      </div>

    </div>
    <footer>

      <small>Copyright &copy; <time datetime="2017">2017</time></small>

    </footer>
  </body>
</html>
