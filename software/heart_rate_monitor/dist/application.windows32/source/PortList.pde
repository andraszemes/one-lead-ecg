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
    this.getCaptionLabel().set("Vybrať port");
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