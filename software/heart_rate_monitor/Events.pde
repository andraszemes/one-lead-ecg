void serialEvent (Serial activePort) 
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
    inByte = map(float(inString), 0, 1023, 0, height);
    
    // If recording is on write data to file
    if(recordToggleState == true && file != null) {
      file.println(inString);
    }
    
    // BPM calculation check
    if (inByte > threshold && belowThreshold == true)
    {
      calculateBPM();
      belowThreshold = false;
    }
    else if(inByte < threshold)
    {
      belowThreshold = true;
    }
  }
}
 
void controlEvent(ControlEvent theEvent) {
  // PulldownMenu is if type ControlGroup.
  // A controlEvent will be triggered from within the ControlGroup.
  // therefore you need to check the originator of the Event with

  if (theEvent.isController() && portList.isMouseOver()) {
    int selectedIndex = int(theEvent.getController().getValue());
    String selectedPort = portList.getList()[selectedIndex];
    
    if(activePort != null) {
      activePort.clear();
      activePort.stop();
    }
    
    try {
      activePort = new Serial(this, selectedPort, 115200);
      println("Connected to " + selectedPort);
    } catch(Exception e) {
      showMessageDialog(null, "Chyba pri otváraní sériového portu " + selectedPort, "Alert", ERROR_MESSAGE);
    }
    portList.refresh();
    background(0xff);
  }
}

// MousePressed Event
void mousePressed() {
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
      file = createWriter("record-" + System.currentTimeMillis() + ".txt");
    } else {
      file.flush();
      file.close();
    }
  }
}