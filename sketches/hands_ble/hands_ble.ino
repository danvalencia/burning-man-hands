/*
  This example will turn ON/OFF LED on pin 13 when receiving
  command 0x01/0x00.
*/

#include <SPI.h>
#include "Adafruit_WS2801.h"
#include <ble.h>

/* PIN for LED */
#define PIN    13

/* Command: ON/OFF */
#define ON     0x01
#define OFF    0x00

#define MAX_COUNT 10000

int count = 0;

int dataPin  = 2;    // Yellow wire on Adafruit Pixels
int clockPin = 3;    // Green wire on Adafruit Pixels

Adafruit_WS2801 strip = Adafruit_WS2801(20, dataPin, clockPin);


void setup()
{
  pinMode(PIN, OUTPUT);
  
  SPI.setDataMode(SPI_MODE0);
  SPI.setBitOrder(LSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV16);
  SPI.begin();
  
  Serial.begin(115200);
   while (!Serial) {
      ; // wait for serial port to connect. Needed for Leonardo only
  }
  
  strip.begin();

  // Update LED contents, to start they are all 'off'
  strip.show();


  ble_begin();
}

void loop()
{
  
//  colorWipe(Color(255, 0, 0), 50);
//  colorWipe(Color(0, 255, 0), 50);
//  colorWipe(Color(0, 0, 255), 50);

  Serial.println("About to check if BLE is available!");

  if (ble_available())
  {
    Serial.println("BLE is Available!");
    byte command = ble_read();
    byte red = ble_read();
    byte green = ble_read();
    byte blue = ble_read();
    
    if (command == ON)
      colorWipe(Color(red, green, blue), 50);
    else if (command == OFF)
      colorWipe(Color(0, 255, 0), 50);

    Serial.println(command, HEX);
  }
  
  if(count == MAX_COUNT) 
  {
    count = 0;
    Serial.println("BLE Events have been processed!");
  }
  else
  {
    count++; 
  }
  ble_do_events();
}

// fill the dots one after the other with said color
// good for testing purposes
void colorWipe(uint32_t c, uint8_t wait) {
  int i;
  
  for (i=0; i < strip.numPixels(); i++) {
      strip.setPixelColor(i, c);
      strip.show();
      delay(wait);
  }
}

/* Helper functions */

// Create a 24 bit color value from R,G,B
uint32_t Color(byte r, byte g, byte b)
{
  uint32_t c;
  c = r;
  c <<= 8;
  c |= g;
  c <<= 8;
  c |= b;
  return c;
}

