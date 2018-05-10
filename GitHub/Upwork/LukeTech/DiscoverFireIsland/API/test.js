/*

https://itunes.apple.com/us/app/fire-island-app/id370129734?mt=8


Plugin Name: Mobile_API
Plugin URI: http://www.discoverfireisland.com
Description: Adding a Mobile API plugin to connect to the Fire Island iOS Mobile App
Author: Melissa Hong
Author URI: http://www.melissaehong.com

1. post new business listing
POST to http://www.fireisland.com/wpcontent/plugins/business-directory/requests.php
Parameters:
"action" : "AddListing",
"category_id" : selected category,
"name" : name,
"email" : email,
"cName" : company name,
"description" : company description,
"keywords" : keywords,
"website" : company email,
"phone" : company phone,
"street1" : company address 1,
"street2" : company address 2,
"city" : company city,
"state" : company state,
"zip" : company zip,
"country" : "USA"


2. fetch events
GET http://www.fireisland.com/wp-admin/events.php
Response: expects to receive a JSON array of events each
containing the following fields:
id
eventTitle
eventDesceription
eventLocation
eventLinkout
eventStartDate (format yyyy-MM-dd)
eventStartTime
eventEndDate (format yyyy-MM-dd)
eventEndTime
*/
function getEvents(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/tribe/events/v1/events');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        console.log(data);
        createHTML(data);
      } else {
        console.log("We connected to the server, but it returned an error.");
    }
  };

  ourRequest.onerror = function(){
    console.log("Connection error");
  };

  ourRequest.send();
}


function createHTML(eventsData){
  var ourHTMLString = '';
  for (i = 0; i < eventsData.length; i++){
    ourHTMLString += '<h2>' + eventsData[i].title + '</h2>';
    ourHTMLString += 'ID: ' + eventsData[i].id + '<br>';
    ourHTMLString += 'Title: ' + eventData[i].title + '<br>';
    ourHTMLString += 'Description: '+ eventData[i].description + '<br>';
    ourHTMLString += 'Location: '+ eventData[i].venue + '<br>';
    ourHTMLString += 'Link: ' + eventData[i].website + '<br>';
    ourHTMLString += 'Start Date and Time: '+ eventData[i].start_date + '<br>';
    ourHTMLString += 'End Date and Time: ' + eventData[i].end_date + '<br>';
    ourHTMLString += 'End Time: ';
  }
  return ourHTMLString;
}


/*
3. fetch directory for category
POST to http://www.fireisland.com/wpcontent/plugins/business-directory/requests.php
Parameters:
"action":"SearchListings",
"category" : categoryId
Response: expects to receive some FORMATTED HTML for
direct display in the app (we can alter this if you like so the
app is responsible for displaying the results)




4. upload picture
POST to http://www.fireisland.com/wpcontent/plugins/photosmashgalleries/photosmashupload.php
Parameters: "image_caption" and a JPEG-formatted image
data (I assume it's sent as multipart data)


5. fetch image galleries
GET http://www.fireisland.com/my/galleries.php
Response: expects an array of objects each with "id" and
"name", to represent the galleries
*/
function getImages(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/media?media_type=image');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        console.log(data);
        createHTML(data);
      } else {
        console.log("We connected to the server, but it returned an error.");
    }
  };

  ourRequest.onerror = function(){
    console.log("Connection error");
  };

  ourRequest.send();
}


function createHTML(imagesData){
  var ourHTMLString = '';
  for (i = 0; i < eventsData.length; i++){
    ourHTMLString += '<h2>' + eventsData[i].file + '</h2>';
    ourHTMLString += 'ID: ' + eventsData[i].id + '<br>';
    ourHTMLString += 'Title: ' + eventData[i].title + '<br>';
  }
  return ourHTMLString;
}


/*

6. fetch images for gallery
GET
http://www.fireisland.com/my/galleries.php?id={galleryId}
Response: expects an array of objects representing images
for the given gallery, each with the following fields: "id",
"name", "mini_url", "image_url" (I believe "mini_url" is a
thumbnail)
*/
function getImages(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/media?media_type=image');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        console.log(data);
        createHTML(data);
      } else {
        console.log("We connected to the server, but it returned an error.");
    }
  };

  ourRequest.onerror = function(){
    console.log("Connection error");
  };

  ourRequest.send();
}


function createHTML(imagesData){
  var ourHTMLString = '';
  for (i = 0; i < eventsData.length; i++){
    ourHTMLString += '<h2>' + eventsData[i].file + '</h2>';
    ourHTMLString += 'ID: ' + eventsData[i].id + '<br>';
    ourHTMLString += 'Title: ' + eventData[i].title + '<br>';
		ourHTMLString += 'Thumbnail: ' + eventsData[i].thumbnail + '<br>';
		ourHTMLString += 'Image Link: ' + eventData[i].source_url + '<br>';
  }
  return ourHTMLString;
}




/*

7. fetch ferry times for given filter
GET
http://www.fireisland.com/my2/webservice/{id}/{date}/0
where {id} is based on the "serverId" in the following table of
destinations:
[FerryLocation locationWithStartPoint:@"Bay Shore"
finishPoint:@"Atlantique" serverId:@"16"],
[FerryLocation locationWithStartPoint:@"Sayville"
finishPoint:@"Cherry Grove" serverId:@"27"],
[FerryLocation locationWithStartPoint:@"Patchogue"
finishPoint:@"Davis Park" serverId:@"25"],
[FerryLocation locationWithStartPoint:@"Bay Shore"
finishPoint:@"Dunewood" serverId:@"17"],
[FerryLocation locationWithStartPoint:@"Bay Shore"
finishPoint:@"Fair Harbor" serverId:@"18"],
[FerryLocation locationWithStartPoint:@"Sayville"
finishPoint:@"Fire Island Pines" serverId:@"28"],
[FerryLocation locationWithStartPoint:@"Bay Shore"
finishPoint:@"Kismet" serverId:@"19"],
[FerryLocation locationWithStartPoint:@"Bay Shore"
finishPoint:@"Ocean Bay Park" serverId:@"20"],
[FerryLocation locationWithStartPoint:@"Bay Shore"
finishPoint:@"Ocean Beach" serverId:@"21"],
[FerryLocation locationWithStartPoint:@"Sayville"
finishPoint:@"Sailor’s Haven" serverId:@"29"],
[FerryLocation locationWithStartPoint:@"Bay Shore"
finishPoint:@"Saltaire" serverId:@"23"],
[FerryLocation locationWithStartPoint:@"Bay Shore"
finishPoint:@"Seaview" serverId:@"24"],
[FerryLocation locationWithStartPoint:@"Sayville"
finishPoint:@"Sunken Forest"serverId:@"30"],
[FerryLocation locationWithStartPoint:@"Patchogue"
finishPoint:@"Watch Hill" serverId:@"26"],
[FerryLocation locationWithStartPoint:@"Sayville"
finishPoint:@"Water Island" serverId:@"31"]
and {date} is in the format: yyyy-MM-dd
Response: expects an array of the ferry times, each has the
following fields: "time", "note"


*/
