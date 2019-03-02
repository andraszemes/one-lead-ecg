#include <FIRFilter.h>
#include <IIRFilter.h>
#include <SPI.h>
#include <SD.h>


// ECG SAMPLE FREQUENCY : 360 Hz
const double ECG_SAMPLE_FREQUENCY  = 360;

// ECG AND LED INTERVALS (PERIOD) IN MICROSECONDS : T=1/f
const static unsigned long ECG_INTERVAL = round(1e6 / ECG_SAMPLE_FREQUENCY);
const static unsigned long LED_INTERVAL = 1e6;

// DEFINE I/O PINS
const uint8_t ECG_PIN = A0;
const uint8_t LED_PIN = 2;
const uint8_t SD_PIN = 10;

// SHIFT WAVEFORM CENTER TO 511
const int16_t DC_OFFSET = 511;

// DEFINE FILTER COEFFICIENTS
// 50 Hz notch
const double b_notch[] = { 1.39972748302835,  -1.79945496605670, 1.39972748302835 };

// 35 Hz Butterworth low-pass
const double b_lp[] = { 0.00113722762905776, 0.00568613814528881, 0.0113722762905776,  0.0113722762905776,  0.00568613814528881, 0.00113722762905776 };
const double a_lp[] = { 1, -3.03124451613593, 3.92924380774061,  -2.65660499035499, 0.928185738776705, -0.133188755896548 };
// 0.3 Hz high-pass
const double b_hp[] = { 1, -1 };
const double a_hp[] = { 1, -0.995 };


// INITIALIZE FILTERS
FIRFilter notch(b_notch);
IIRFilter lp(b_lp, a_lp);
IIRFilter hp(b_hp, a_hp);


// DECLARE FILE POINTER
File file;


// SETUP SEQUENCE
void setup() {
  // Set LED pin as output and turn it on
  pinMode(LED_PIN, OUTPUT);
  digitalWrite(LED_PIN, HIGH);

  // Random analog noise will cause the call to randomSeed() to generate
  // different seed numbers each time the sketch runs.
  randomSeed(analogRead(1));
  
  // Begin serial communication at 115200 bps
  Serial.begin(115200);

  // Check SD module
  if (!SD.begin(SD_PIN)) {
    Serial.println("SD module initialization failed!");
    return;
  }
  
  // Open new file for writing on the SD card.
  file = SD.open("log" + String(random(1000)) + ".csv", FILE_WRITE);
}



// PROGRAM LOOP
void loop() {
  // Recorded instance of last measurement
  static unsigned long ecgPrevmicros = micros();
  static unsigned long ledPrevmicros = micros();
  int16_t ecgValue;

  // LED blink
  if(micros() - ledPrevmicros >= LED_INTERVAL) {
    file.flush();
    digitalWrite(LED_PIN, !digitalRead(LED_PIN));
    ledPrevmicros += LED_INTERVAL;
  }

  // Measure and send ECG signal
  if (!Serial) {
    // Update time of last measurement
    ecgPrevmicros = micros();
  } 
  else if (micros() - ecgPrevmicros >= ECG_INTERVAL) {
    // Read measured and filtered analog value
    ecgValue = readEcgValue();
    
    // Send ECG value on Serial interface
    Serial.println(ecgValue);

    // If file is open, write ECG value
    if(file) {
      file.println(ecgValue);
    }
    
    // Increment EcgPrevmicros
    ecgPrevmicros += ECG_INTERVAL;
  }
}


// HELPER FUNCTION
// Read and filter ECG analog value
int16_t readEcgValue() {
  // 16-bit integer : save measured value from ECG pin
  int16_t value = analogRead(ECG_PIN);

  // Apply filters to measured value
  double filtered = notch.filter(
                      lp.filter(
                      hp.filter(value - DC_OFFSET)));

  // Offset filtered value
  value = round(filtered) + DC_OFFSET;

  // Return result
  return value;
}

