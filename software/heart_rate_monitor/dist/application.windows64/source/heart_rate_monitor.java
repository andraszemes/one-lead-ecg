import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import controlP5.*; 
import java.io.FileWriter; 
import static javax.swing.JOptionPane.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class heart_rate_monitor extends PApplet {





   
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

public void setup () {
      // set the window size:
  cp5 = new ControlP5(this);
  portList = new PortList(cp5, "serial-port-list");
  saveButton = new SaveButton(cp5, "save-image-button");
  recordToggle = new RecordToggle(cp5, "record-on-off");
  font = createFont("Ariel", 12, true);
  background(0xff);
}

public void draw () {
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
public void serialEvent (Serial activePort) 
{
  // get the ASCII string:
  String inString = activePort.readStringUntil('\n');

  if (inString != null) 
  {
    // Trim off any whitespace:
    inString = trim(inString);
    
    //Set stroke to red ( R, G, B)
    stroke(0xff, 0, 0); 
    
    // Map incoming data to window height
    inByte = map(PApplet.parseFloat(inString), 350, 700, 0, height);
    
    // If recording is on write data to file
    if(recordToggleState == true && file != null) {
      file.println(inString);
    }
  }
}
 
public void controlEvent(ControlEvent theEvent) {
  // PulldownMenu is if type ControlGroup.
  // A controlEvent will be triggered from within the ControlGroup.
  // therefore you need to check the originator of the Event with

  if (theEvent.isController() && portList.isMouseOver()) {
    int selectedIndex = PApplet.parseInt(theEvent.getController().getValue());
    String selectedPort = portList.getList()[selectedIndex];
    
    if(activePort != null) {
      activePort.clear();
      activePort.stop();
    }
    
    try {
      activePort = new Serial(this, selectedPort, 115200);
      println("Connected to " + selectedPort);
    } catch(Exception e) {
      showMessageDialog(null, "Chyba pri otv\u00e1ran\u00ed s\u00e9riov\u00e9ho portu " + selectedPort, "Alert", ERROR_MESSAGE);
    }
    portList.refresh();
    background(0xff);
  }
}

// MousePressed Event
public void mousePressed() {
  // Save current frame on pressing save button
  if(saveButton.isMouseOver()) {
    saveFrame("ecg-frame-####.png");
  }
  
  // Switch toggle state
  // if switch is turned ON  -> open file for writing
  // if switch is turned OFF -> close file
  if(recordToggle.isMouseOver()) {  
    recordToggleState = !recordToggleState;
    if(recordToggleState == true) {
      file = createWriter("record-" + System.currentTimeMillis() + ".csv");
    } else {
      file.flush();
      file.close();
    }
  }
}
class PortList extends DropdownList {
  String[] portsList;
 
  PortList(ControlP5 cp5, String name) {
    super(cp5, name);
    portsList = Serial.list(); // Initialize Serial Port Selection DropdownList
    this.customize();
  }
  
  private void customize() {
    this.setPosition(860, 10);
    this.setSize(130, 200);
    this.addItems(this.portsList);
    this.setOpen(false);
    this.setItemHeight(20);
    this.setBarHeight(20);
    this.setFont(createFont("Ariel", 12, true));
    this.getValueLabel().getStyle().marginTop = 3;
    this.getCaptionLabel().getStyle().marginTop = 3; 
    this.getCaptionLabel().getStyle().marginLeft = 3; 
    this.getCaptionLabel().set("Vybra\u0165 port");
  }
  
  public void refresh() {
    this.portsList = Serial.list();
    this.clear();
    this.addItems(portsList);
  }
  
  public String[] getList() {
    return this.portsList;
  }
}
class RecordToggle extends Toggle {

  RecordToggle(ControlP5 cp5, String name) {
    super(cp5, name);
    this.customize();
    this.addTextlabel(cp5);
  }
  
  private void customize() {
    this.setPosition(630, 10);
    this.setSize(80, 20);
    this.setValue(true);
    this.setMode(ControlP5.SWITCH);
  }
  
  private void addTextlabel(ControlP5 cp5) {
    cp5.addTextlabel("label")
         .setText("REC")
         .setPosition(633, 12)
         .setColorValue(0xff)
         .setFont(createFont("Ariel", 12, true));
  }
}
class SaveButton extends Button {

  SaveButton(ControlP5 cp5, String name) {
    super(cp5, name);
    this.customize();
  }
  
  private void customize() {
    this.setPosition(720, 10);
    this.setSize(130, 20);
    this.setFont(createFont("Ariel", 12, true));
    this.align(CENTER, CENTER, LEFT ,CENTER); 
    this.getCaptionLabel().getStyle().marginLeft = 3; 
    this.getCaptionLabel().set("Ulo\u017ei\u0165 sn\u00edmku");
  }
}
  public void settings() {  size(1000, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "heart_rate_monitor" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
