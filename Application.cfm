
<!--- Set application name and enable Client and Session variables. ---> 
<cfapplication name="iCapture_JDawson" 
  clientmanagement="No" 
  clientstorage="iCapture" 
  sessionmanagement="No"> 

<!--- Set page processing attributes. ---> 
<cfsetting showDebugOutput="Yes"> 

<cfset datasource="candidate_dawsonj">

<cfset apiBaseUrl="https://api.themoviedb.org">
<cfset apiKey="?api_key=82e7a9c04051d93244cc586b2e6190fa">
