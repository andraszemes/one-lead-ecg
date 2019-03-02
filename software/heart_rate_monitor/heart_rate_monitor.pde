import processing.serial.*;
import controlP5.*;
import java.io.FileWriter;
import static javax.swing.JOptionPane.*;
   
ControlP5 cp5;
Serial activePort;    // The serial port
PortList portList;
SaveButton saveButton;
RecordToggle recordToggle;
PrintWriter file;
boolean recordToggleState = false;
int xPosition = 1;         // horizontal position of the graph
float yPosition1 = 0;
float yPosition2 = 0;
float inByte = 0;
PFont font;

void setup () {
  size(1000, 500);    // set the window size:
  cp5 = new ControlP5(this);
  portList = new PortList(cp5, "serial-port-list");
  saveButton = new SaveButton(cp5, "save-image-button");
  recordToggle = new RecordToggle(cp5, "record-on-off");
  font = createFont("Ariel", 12, true);
  background(0xff);
}

void draw () {
  if(inByte != 0) {
    //Map and draw the line for new data point
    yPosition2 = height - inByte;
    println(inByte);
    line(xPosition-1, yPosition1, xPosition, yPosition2);
    yPosition1 = yPosition2;
  
    // at the edge of the screen, go back to the beginning:
    if (xPosition >= width) {
      xPosition = 0;
      background(0xff);
    } else {
      // increment the horizontal position:
      xPosition++;
    }
  } else {
    background(0xff);
  }
}