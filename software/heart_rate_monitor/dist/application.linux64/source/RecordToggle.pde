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