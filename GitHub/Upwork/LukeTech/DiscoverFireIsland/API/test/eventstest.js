/*fetch events
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
eventEndTime*/

var discoverfireislandEventsBtn = document.getElementById("discoverfireisland-events-btn");
var discoverfireislandEventsContainer = document.getElementById("discoverfireisland-events-container");

if (discoverfireislandEventsBtn){
  discoverfireislandEventsBtn.addEventListener("click", function(){
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
});
}

function createHTML(eventsData){
    ourHTMLString = '';
    for (var i = 0 ; i < eventsData.events.length; i++){
    ourHTMLString += "<h2> Id: " + eventsData.events[i].id + '<br>';
    ourHTMLString += "Title: " + eventsData.events[i].title + '<br>';
    ourHTMLString += "Description: " + eventsData.events[i].description + '<br>';
    ourHTMLString += "Location: " + eventsData.events[i].venue.venue + '<br>';
    ourHTMLString += "Link: " + eventsData.events[i].venue.url + '<br>';
    ourHTMLString += "Start Date: " + eventsData.events[i].start_date_details.month + '/' + eventsData.events[i].start_date_details.day + '/' + eventsData.events[i].start_date_details.year + '<br>';
    ourHTMLString += "End Date: " + eventsData.events[i].end_date_details.day + '/' + eventsData.events[i].end_date_details.month + '/' + eventsData.events[i].end_date_details.year + '<br>';

    }
  discoverfireislandEventsContainer.innerHTML = ourHTMLString;
}
