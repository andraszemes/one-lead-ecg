var dataPoints = [];
var query = new URL(window.location.href).searchParams.get("f");

// If the "f" (filename) URL parameter is present, show graph
if(query) {
  document.getElementById("chart-container").style.display = "inline-block";
  document.getElementById("drop-zone").style.display = "none";
  document.getElementById("url-bar").value = window.location.href;
  openFile(query);
}

// Configure chart
var chart = new CanvasJS.Chart("graph", {
  animationEnabled: true,
  exportEnabled: true,
  theme: "dark2",
  title: {
    text: "Elektrokardiogram"
  },
  axisY: {
    title: "Amplitúda",
    includeZero: false
  },
  data: [{
    type: "spline",
    toolTipContent: "{y}",
    dataPoints: dataPoints
  }]
});

// Parse CSV file
function getDataPointsFromCSV(csv) {
  var csvLines = points = [];
  csvLines = csv.split(/[\r?\n|\r|\n]+/);
  for (var i = 0; i < csvLines.length; i++) {
    if (csvLines[i].length > 0) {
      dataPoints.push({
        label: i,
        y: parseFloat(csvLines[i])
      });
    }
  }
  chart.render();
}

// Retreive CSV file from server based on the "f" (filename) URL parameter
function openFile(query) {
  var request = new XMLHttpRequest();
  request.addEventListener("load", function(e) {
    getDataPointsFromCSV(e.target.response);
  });
  request.open("GET", "/uploads/" + query + ".csv");
  request.send();
}

// Submit upload form on choosing file
function fileInputHandler(input) {
  if(input.files && input.files[0]) {
    document.getElementById("upload-form").submit(); 
  }
}

// Prevent default behavior (Prevent file from being opened)
// Append dropped files to file input
// Submit upload form
function dropHandler(e) {
  e.preventDefault();
  document.getElementById("inputfile").files = e.dataTransfer.files;
  document.getElementById("upload-form").submit(); 
}

// Prevent default behavior (Prevent file from being opened)
function dragOverHandler(e) {  
  e.preventDefault();
}