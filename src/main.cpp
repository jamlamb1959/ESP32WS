#include <Arduino.h>

#include <WiFi.h>

#define LED                 2
#define BLINKINV            500

void setup() 
    {
    Serial.begin( 115200 );

    delay( 1000 );

    Serial.printf( "Compile: %s\r\n", __COMPILEDATE__ );
    }

#define BLINKINV 1000

static bool ledState_g = false;

static int64_t nxtTime_g = 0;

void loop(
        ) 
    {
    if ( millis() > nxtTime_g )
        {
        nxtTime_g = millis() + BLINKINV;

        Serial.printf( "LED: %s\r\n", (ledState_g) ? "HIGH" : "LOW" );
        digitalWrite( LED, (ledState_g) ? HIGH : LOW );
        ledState_g = !(ledState_g);
        }
    }
