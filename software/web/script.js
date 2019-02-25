var dataPoints = [];

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

//CSV Format
//Year,Volume
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

function openFile(file) {
  var reader = new FileReader();
  reader.addEventListener("load", function (e) {
    document.getElementById("chart_container").style.display = "inline-block";
    document.getElementById("drop_zone").style.display = "none";
    getDataPointsFromCSV(e.target.result);
  });
  if(file.type == "text/csv") {
    reader.readAsBinaryString(file);
  }
}

function fileInputHandler(input) {
  if(input.files && input.files[0]) {
    openFile(input.files[0])
  }
}

function dropHandler(e) {
  // Prevent default behavior (Prevent file from being opened)
  e.preventDefault();
  openFile(e.dataTransfer.files[0]);
}

function dragOverHandler(e) {
  // Prevent default behavior (Prevent file from being opened)
  e.preventDefault();
}