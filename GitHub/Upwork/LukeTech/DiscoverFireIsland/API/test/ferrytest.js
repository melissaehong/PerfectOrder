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

/////
/////I don't have Ocean Beach Ferries yet, not coded in...///
////

*/
//Bay Shore to Ocean Bay Park buttons and containers
var BStoOBPMondayBtn = document.getElementById("BStoOBP-Monday-btn");
var BStoOBPMondayContainer = document.getElementById("BStoOBP-Monday-container");
var BStoOBPTuesdayBtn = document.getElementById("BStoOBP-Tuesday-btn");
var BStoOBPTuesdayContainer = document.getElementById("BStoOBP-Tuesday-container");
var BStoOBPWednesdayBtn = document.getElementById("BStoOBP-Wednesday-btn");
var BStoOBPWednesdayContainer = document.getElementById("BStoOBP-Wednesday-container");
var BStoOBPThursdayBtn = document.getElementById("BStoOBP-Thursday-btn");
var BStoOBPThursdayContainer = document.getElementById("BStoOBP-Thursday-container");
var BStoOBPFridayBtn = document.getElementById("BStoOBP-Friday-btn");
var BStoOBPFridayContainer = document.getElementById("BStoOBP-Friday-container");
var BStoOBPSaturdayBtn = document.getElementById("BStoOBP-Saturday-btn");
var BStoOBPSaturdayContainer = document.getElementById("BStoOBP-Saturday-container");
var BStoOBPSundayBtn = document.getElementById("BStoOBP-Sunday-btn");
var BStoOBPSundayContainer = document.getElementById("BStoOBP-Sunday-container");

//Ocean Bay Park to Bay Shore buttons and containers
var OBPtoBSMondayBtn = document.getElementById("OBPtoBS-Monday-btn");
var OBPtoBSMondayContainer = document.getElementById("OBPtoBS-Monday-container");
var OBPtoBSTuesdayBtn = document.getElementById("OBPtoBS-Tuesday-btn");
var OBPtoBSTuesdayContainer = document.getElementById("OBPtoBS-Tuesday-container");
var OBPtoBSWednesdayBtn = document.getElementById("OBPtoBS-Wednesday-btn");
var OBPtoBSWednesdayContainer = document.getElementById("OBPtoBS-Wednesday-container");
var OBPtoBSThursdayBtn = document.getElementById("OBPtoBS-Thursday-btn");
var OBPtoBSThursdayContainer = document.getElementById("OBPtoBS-Thursday-container");
var OBPtoBSFridayBtn = document.getElementById("OBPtoBS-Friday-btn");
var OBPtoBSFridayContainer = document.getElementById("OBPtoBS-Friday-container");
var OBPtoBSSaturdayBtn = document.getElementById("OBPtoBS-Saturday-btn");
var OBPtoBSSaturdayContainer = document.getElementById("OBPtoBS-Saturday-container");
var OBPtoBSSundayBtn = document.getElementById("OBPtoBS-Sunday-btn");
var OBPtoBSSundayContainer = document.getElementById("OBPtoBS-Sunday-container");

//Bay Shore to Ocean Beach buttons and containers
var BStoOBMondayBtn = document.getElementById("BStoOB-Monday-btn");
var BStoOBMondayContainer = document.getElementById("BStoOB-Monday-container");
var BStoOBTuesdayBtn = document.getElementById("BStoOB-Tuesday-btn");
var BStoOBTuesdayContainer = document.getElementById("BStoOB-Tuesday-container");
var BStoOBWednesdayBtn = document.getElementById("BStoOB-Wednesday-btn");
var BStoOBWednesdayContainer = document.getElementById("BStoOB-Wednesday-container");
var BStoOBThursdayBtn = document.getElementById("BStoOB-Thursday-btn");
var BStoOBThursdayContainer = document.getElementById("BStoOB-Thursday-container");
var BStoOBFridayBtn = document.getElementById("BStoOB-Friday-btn");
var BStoOBFridayContainer = document.getElementById("BStoOB-Friday-container");
var BStoOBSaturdayBtn = document.getElementById("BStoOB-Saturday-btn");
var BStoOBSaturdayContainer = document.getElementById("BStoOB-Saturday-container");
var BStoOBSundayBtn = document.getElementById("BStoOB-Sunday-btn");
var BStoOBSundayContainer = document.getElementById("BStoOB-Sunday-container");

//Ocean Beach to Bay Shore buttons and containers
var OBtoBSMondayBtn = document.getElementById("OBtoBS-Monday-btn");
var OBtoBSMondayContainer = document.getElementById("OBtoBS-Monday-container");
var OBtoBSTuesdayBtn = document.getElementById("OBtoBS-Tuesday-btn");
var OBtoBSTuesdayContainer = document.getElementById("OBtoBS-Tuesday-container");
var OBtoBSWednesdayBtn = document.getElementById("OBtoBS-Wednesday-btn");
var OBtoBSWednesdayContainer = document.getElementById("OBtoBS-Wednesday-container");
var OBtoBSThursdayBtn = document.getElementById("OBtoBS-Thursday-btn");
var OBtoBSThursdayContainer = document.getElementById("OBtoBS-Thursday-container");
var OBtoBSFridayBtn = document.getElementById("OBtoBS-Friday-btn");
var OBtoBSFridayContainer = document.getElementById("OBtoBS-Friday-container");
var OBtoBSSaturdayBtn = document.getElementById("OBtoBS-Saturday-btn");
var OBtoBSSaturdayContainer = document.getElementById("OBtoBS-Saturday-container");
var OBtoBSSundayBtn = document.getElementById("OBtoBS-Sunday-btn");
var OBtoBSSundayContainer = document.getElementById("OBtoBS-Sunday-container");


////Bay Shore to Ocean Bay Park Week /////

//fetch Bay Shore to Ocean Bay Park Monday
if (BStoOBPMondayBtn){
  BStoOBPMondayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13068');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLMondayBSOBP(data);
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

function createHTMLMondayBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBPMondayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OBP Tuesday

if (BStoOBPTuesdayBtn){
  BStoOBPTuesdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13076');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLTuesdayBSOBP(data);
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

function createHTMLTuesdayBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBPTuesdayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OBP Wednesday
if (BStoOBPWednesdayBtn){
  BStoOBPWednesdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13079');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLWednesdayBSOBP(data);
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

function createHTMLWednesdayBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBPWednesdayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OBP Thursday
if (BStoOBPThursdayBtn){
  BStoOBPThursdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13082');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLThursdayBSOBP(data);
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

function createHTMLThursdayBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBPThursdayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OBP Friday
if (BStoOBPFridayBtn){
  BStoOBPFridayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13085');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLFridayBSOBP(data);
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

function createHTMLFridayBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBPFridayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OBP Saturday
if (BStoOBPSaturdayBtn){
  BStoOBPSaturdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13087');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLSaturdayBSOBP(data);
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

function createHTMLSaturdayBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBPSaturdayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OBP Sunday
if (BStoOBPSundayBtn){
  BStoOBPSundayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13089');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLSundayBSOBP(data);
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

function createHTMLSundayBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBPSundayContainer.innerHTML = ourHTMLString;
}

//// Ocean Bay Park to Bay Shore Week /////

//fetch Ocean Bay Park to Bay Shore Monday
if (OBPtoBSMondayBtn){
  OBPtoBSMondayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13092');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLMondayBackBSOBP(data);
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

function createHTMLMondayBackBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBPtoBSMondayContainer.innerHTML = ourHTMLString;
}

//Fetch OBP to BS Tuesday

if (OBPtoBSTuesdayBtn){
  OBPtoBSTuesdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13093');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLTuesdayBackBSOBP(data);
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

function createHTMLTuesdayBackBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBPtoBSTuesdayContainer.innerHTML = ourHTMLString;
}

//Fetch OBP to BS Wednesday
if (OBPtoBSWednesdayBtn){
  OBPtoBSWednesdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13094');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLWednesdayBackBSOBP(data);
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

function createHTMLWednesdayBackBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBPtoBSWednesdayContainer.innerHTML = ourHTMLString;
}

//Fetch OBP to BS Thursday
if (OBPtoBSThursdayBtn){
  OBPtoBSThursdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13095');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLThursdayBackBSOBP(data);
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

function createHTMLThursdayBackBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBPtoBSThursdayContainer.innerHTML = ourHTMLString;
}

//Fetch OBP to BS Friday
if (OBPtoBSFridayBtn){
  OBPtoBSFridayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13096');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLFridayBackBSOBP(data);
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

function createHTMLFridayBackBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBPtoBSFridayContainer.innerHTML = ourHTMLString;
}

//Fetch OBP to BS Saturday
if (OBPtoBSSaturdayBtn){
  OBPtoBSSaturdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13097');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLSaturdayBackBSOBP(data);
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

function createHTMLSaturdayBackBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBPtoBSSaturdayContainer.innerHTML = ourHTMLString;
}

//Fetch OBP to BS Sunday
if (OBPtoBSSundayBtn){
  OBPtoBSSundayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13098');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLSundayBackBSOBP(data);
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

function createHTMLSundayBackBSOBP(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBPtoBSSundayContainer.innerHTML = ourHTMLString;
}

////Bay Shore to Ocean Beach Week /////

//fetch Bay Shore to Ocean Beach Monday
if (BStoOBMondayBtn){
  BStoOBMondayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13108');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLMonday(data);
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

function createHTMLMonday(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBMondayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OB Tuesday

if (BStoOBTuesdayBtn){
  BStoOBTuesdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13109');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLTuesday(data);
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

function createHTMLTuesday(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBTuesdayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OB Wednesday
if (BStoOBWednesdayBtn){
  BStoOBWednesdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13110');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLWednesday(data);
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

function createHTMLWednesday(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBWednesdayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OB Thursday
if (BStoOBThursdayBtn){
  BStoOBThursdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13111');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLThursday(data);
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

function createHTMLThursday(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBThursdayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OB Friday
if (BStoOBFridayBtn){
  BStoOBFridayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13112');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLFriday(data);
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

function createHTMLFriday(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBFridayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OB Saturday
if (BStoOBSaturdayBtn){
  BStoOBSaturdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13113');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLSaturday(data);
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

function createHTMLSaturday(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBSaturdayContainer.innerHTML = ourHTMLString;
}

//Fetch BS to OB Sunday
if (BStoOBSundayBtn){
  BStoOBSundayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13116');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLSunday(data);
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

function createHTMLSunday(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  BStoOBSundayContainer.innerHTML = ourHTMLString;
}

//// Ocean Beach to Bay Shore Week /////

//fetch Ocean Beach to Bay Shore Monday
if (OBtoBSMondayBtn){
  OBtoBSMondayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13115');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLMondayBack(data);
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

function createHTMLMondayBack(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBtoBSMondayContainer.innerHTML = ourHTMLString;
}

//Fetch OB to Bay Shore Tuesday

if (OBtoBSTuesdayBtn){
  OBtoBSTuesdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13134');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLTuesdayBack(data);
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

function createHTMLTuesdayBack(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBtoBSTuesdayContainer.innerHTML = ourHTMLString;
}

//Fetch OB to BS Wednesday
if (OBtoBSWednesdayBtn){
  OBtoBSWednesdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13137');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLWednesdayBack(data);
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

function createHTMLWednesdayBack(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBtoBSWednesdayContainer.innerHTML = ourHTMLString;
}

//Fetch OB to BS Thursday
if (OBtoBSThursdayBtn){
  OBtoBSThursdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13138');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLThursdayBack(data);
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

function createHTMLThursdayBack(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBtoBSThursdayContainer.innerHTML = ourHTMLString;
}

//Fetch OB to BS Friday
if (OBtoBSFridayBtn){
  OBtoBSFridayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13139');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLFridayBack(data);
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

function createHTMLFridayBack(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBtoBSFridayContainer.innerHTML = ourHTMLString;
}

//Fetch OB to BS Saturday
if (OBtoBSSaturdayBtn){
  OBtoBSSaturdayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13140');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        createHTMLSaturdayBack(data);
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

function createHTMLSaturdayBack(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBtoBSSaturdayContainer.innerHTML = ourHTMLString;
}

//Fetch OB to BS Sunday
if (OBtoBSSundayBtn){
  OBtoBSSundayBtn.addEventListener("click", function(){
    var ourRequest = new XMLHttpRequest();
    ourRequest.open('GET', 'https://www.fireisland.com/wp-json/wp/v2/posts?include=13141');
    ourRequest.onload = function(){
      if(ourRequest.status >= 200 && ourRequest.status < 400){
        var data = JSON.parse(ourRequest.responseText);
        console.log(data);
        createHTMLSundayBack(data);
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

function createHTMLSundayBack(ferryData){
    ourHTMLString = '';
    for (var i = 0 ; i < ferryData.length; i++){
    ourHTMLString += ferryData[i].content.rendered + '<p></h2>';

    }
  OBtoBSSundayContainer.innerHTML = ourHTMLString;
}
