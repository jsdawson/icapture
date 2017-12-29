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

    <cfquery name="dbCreate" datasource="#datasource#">
      CREATE TABLE IF NOT EXISTS
        `movies` (
          `id` int(11) NOT NULL PRIMARY KEY,
          `adult` varchar(10) DEFAULT NULL,
          `backdrop_path` varchar(100) DEFAULT NULL,
          `genre_ids` text,
          `original_language` varchar(20) DEFAULT NULL,
          `original_title` varchar(100) DEFAULT NULL,
          `overview` text,
          `popularity` decimal(10,6) DEFAULT NULL,
          `poster_path` varchar(100) DEFAULT NULL,
          `release_date` datetime DEFAULT NULL,
          `title` varchar(100) DEFAULT NULL,
          `video` varchar(10) DEFAULT NULL,
          `vote_average` decimal(4,2) DEFAULT NULL,
          `vote_count` int(11) DEFAULT NULL
        )
    </cfquery>

    <cfquery name="dbVerify" datasource="#datasource#">
      SELECT
        table_name
      FROM
        information_schema.tables;
    </cfquery>

    <cfdump var="#dbVerify#">
  </body>
</html>