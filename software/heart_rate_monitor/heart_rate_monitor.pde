/******************************************************************************
Heart_Rate_Display.ino
Demo Program for AD8232 Heart Rate sensor.
Casey Kuhns @ SparkFun Electronics
6/27/2014
https://github.com/sparkfun/AD8232_Heart_Rate_Monitor

The AD8232 Heart Rate sensor is a low cost EKG/ECG sensor.  This example shows
how to create an ECG with real time display.  The display is using Processing.
This sketch is based heavily on the Graphing Tutorial provided in the Arduino
IDE. http://www.arduino.cc/en/Tutorial/Graph

Resources:
This program requires a Processing sketch to view the data in real time.

Development environment specifics:
  IDE: Arduino 1.0.5
  Hardware Platform: Arduino Pro 3.3V/8MHz
  AD8232 Heart Monitor Version: 1.0

This code is beerware. If you see me (or any other SparkFun employee) at the
local pub, and you've found our code helpful, please buy us a round!

Distributed as-is; no warranty is given.
******************************************************************************/

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
int BPM = 0;
int beat_old = 0;
float[] beats = new float[500];  // Used to calculate average BPM
int beatIndex;
float threshold = 620.0;  //Threshold at which BPM calculation occurs
boolean belowThreshold = true;
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
    
    // draw text for BPM periodically
    if (millis() % 128 == 0){
      fill(0xFF);
      rect(0, 0, 200, 20);
      fill(0x00);
      text("BPM: " + inByte, 15, 10);
    }
  } else {
    background(0xff);
  }
}


void calculateBPM () 
{  
  int beat_new = millis();    // get the current millisecond
  int diff = beat_new - beat_old;    // find the time between the last two beats
  float currentBPM = 60000 / diff;    // convert to beats per minute
  beats[beatIndex] = currentBPM;  // store to array to convert the average
  float total = 0.0;
  for (int i = 0; i < 500; i++){
    total += beats[i];
  }
  BPM = int(total / 500);
  beat_old = beat_new;
  beatIndex = (beatIndex + 1) % 500;  // cycle through the array instead of using FIFO queue
}