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
    this.getCaptionLabel().set("Uložiť snímku");
  }
}