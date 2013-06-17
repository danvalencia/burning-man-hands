#include "Wire.h"
/*
 * SerialReceive sketch
 * Blink the LED at a rate proportional to the received digit value
*/
const int ledPin = 13; // pin the LED is connected to
int   blinkRate=0;     // blink rate stored in this variable

void setup()
{
  Serial.begin(9600); // Initialize serial port to send and receive at 9600 baud
  pinMode(ledPin, OUTPUT); // set this pin as output
}

void loop()
{
  if ( Serial.available()) // Check to see if at least one character is available
  {
    char ch = Serial.read();
    if(ch >= '0' && ch <= '9') // is this an ascii digit between 0 and 9?
    {
       blinkRate = (ch - '0');      // ASCII value converted to numeric value
       blinkRate = blinkRate * 100; // actual blinkrate is 100 mS times received digit
       blinkLoop(ch);
    }
  }
}

// blink the LED with the on and off times determined by blinkRate
void blink()
{
  digitalWrite(ledPin,HIGH);
  delay(300); // delay depends on blinkrate value
  digitalWrite(ledPin,LOW);
  delay(300);
}

void blinkLoop(byte blinkTimes) {
  byte i = 0;
  for(byte b = 0; b < blinkTimes; b++) {
    blink();
  }
  delay(2000);
}