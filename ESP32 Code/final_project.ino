#include "config.h"
#include <Adafruit_Sensor.h>
#include "DHT.h"
#include <ESP8266WiFi.h>
#include "AdafruitIO_WiFi.h"
#include <AceButton.h>
using namespace ace_button;


 
#define WIFI_SSID       "Speed"
#define WIFI_PASS       "14261426@fb"
 
#define IO_USERNAME    "HAR5HA"
#define IO_KEY         "aio_APJg61X0TRy4WUHWHZW3c4IFtQmj"

AdafruitIO_WiFi io(IO_USERNAME, IO_KEY, WIFI_SSID, WIFI_PASS);

//dht11
#define DHTPIN 3 
#define DHTTYPE DHT11   // DHT 11


//relay
#define s1 2
#define s2 0
#define s3 4
#define s4 5

//switch
#define p1 10
#define p2 13
#define p3 12
#define p4 14

//button
ButtonConfig config1;
AceButton button1(&config1);
ButtonConfig config2;
AceButton button2(&config2);
ButtonConfig config3;
AceButton button3(&config3);
ButtonConfig config4;
AceButton button4(&config4);

void handleEvent1(AceButton*, uint8_t, uint8_t);
void handleEvent2(AceButton*, uint8_t, uint8_t);
void handleEvent3(AceButton*, uint8_t, uint8_t);
void handleEvent4(AceButton*, uint8_t, uint8_t);

int x = 0;
boolean a,b,c,d;

DHT dht(DHTPIN, DHTTYPE);


AdafruitIO_Feed *temperature = io.feed("temperature");
AdafruitIO_Feed *humidity = io.feed("humidity");
AdafruitIO_Feed *l1 = io.feed("led-1");
AdafruitIO_Feed *l2 = io.feed("color");
AdafruitIO_Feed *l3 = io.feed("socket");
AdafruitIO_Feed *l4 = io.feed("led-2");


void setup() {

  
  pinMode(s1, OUTPUT);
  pinMode(s2, OUTPUT);
  pinMode(s3, OUTPUT);
  pinMode(s4, OUTPUT);


  pinMode(p1, INPUT_PULLUP);
  pinMode(p2, INPUT_PULLUP);
  pinMode(p3, INPUT_PULLUP);
  pinMode(p4, INPUT_PULLUP);
  
  
  Serial.begin(115200);
  dht.begin();
  Serial.print("Connecting to Adafruit IO");
  io.connect();

  l1->onMessage(handleMessage1);
  l2->onMessage(handleMessage2);
  l3->onMessage(handleMessage3);
  l4->onMessage(handleMessage4);


  // acebutton
  config1.setEventHandler(button1Handler);
  config2.setEventHandler(button2Handler);
  config3.setEventHandler(button3Handler);
  config4.setEventHandler(button4Handler);
  
  button1.init(p1);
  button2.init(p2);
  button3.init(p3);
  button4.init(p4);



  while (io.status() < AIO_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.println(io.statusText());


  l1->get();
  l2->get();
  l3->get();
  l4->get();
}


void loop() {
  
  io.run();
  
  x++;
  if (x == 500)// 102 is 12 sec
  {
 
    float celsius = dht.readTemperature();
    Serial.print("celsius: ");
    Serial.print(celsius);
    Serial.println(" C");
    
    temperature->save(celsius);

    float h = dht.readHumidity();
    Serial.print("humidity: ");
    Serial.print(h);
    Serial.println("%");
    Serial.println("................");

    humidity->save(h);
    x = 0;
  }

  button1.check();
  button2.check();
  button3.check();
  button4.check();
  
}



//offline trigger
void button1Handler(AceButton* button, uint8_t eventType, uint8_t buttonState) {
  Serial.println("EVENT1");
  switch (eventType) {
    case AceButton::kEventPressed:
      Serial.println("kEventPressed");
      l1->save(1);
      digitalWrite(s1, LOW);
      break;
    case AceButton::kEventReleased:
      Serial.println("kEventReleased");
      l1->save(0);
      digitalWrite(s1, HIGH);
      break;
  }
}

void button2Handler(AceButton* button, uint8_t eventType, uint8_t buttonState) {
  Serial.println("EVENT2");
  switch (eventType) {
    case AceButton::kEventPressed:
      Serial.println("kEventPressed");
      l2->save("#ffffff");
      digitalWrite(s2, LOW);
      break;
    case AceButton::kEventReleased:
      Serial.println("kEventReleased");
      l2->save("#000000");
      digitalWrite(s2, HIGH);
      break;
  }
}

void button3Handler(AceButton* button, uint8_t eventType, uint8_t buttonState) {
  Serial.println("EVENT3");
  switch (eventType) {
    case AceButton::kEventPressed:
      Serial.println("kEventPressed");
      l3->save(1);
      digitalWrite(s3, LOW);
      break;
    case AceButton::kEventReleased:
      Serial.println("kEventReleased");
      l3->save(0);
      digitalWrite(s3, HIGH);
      break;
  }
}

void button4Handler(AceButton* button, uint8_t eventType, uint8_t buttonState) {
  Serial.println("EVENT4");
  switch (eventType) {
    case AceButton::kEventPressed:
      Serial.println("kEventPressed");
      l4->save(1);
      digitalWrite(s4, LOW);
      break;
    case AceButton::kEventReleased:
      Serial.println("kEventReleased");
      l4->save(0);
      digitalWrite(s4, HIGH);
      break;
  }
  }


//online trigger

void handleMessage1(AdafruitIO_Data *data)
{
  
  Serial.print("received led-1 <- ");
  if (data->toPinLevel() == HIGH){
    Serial.println("HIGH");
    a=LOW;}
  else{
    Serial.println("LOW");
    a=HIGH;}
  digitalWrite(s1,a);
}


void handleMessage2(AdafruitIO_Data *data)
{
  Serial.print("received rgb-light <- ");
  String st = data->value();
  if (st != "#000000"){
    Serial.println("HIGH");
    b=LOW;}
  else{
    Serial.println("LOW");
    b=HIGH;}
 
  digitalWrite(s2, b);
}

void handleMessage3(AdafruitIO_Data *data)
{
  Serial.print("received socket <- ");

    if (data->toPinLevel() == HIGH){
    Serial.println("HIGH");
    c=LOW;}
  else{
    Serial.println("LOW");
    c=HIGH;}
  digitalWrite(s3,c);
}

void handleMessage4(AdafruitIO_Data *data)
{
  Serial.print("received led-2 <- ");

    if (data->toPinLevel() == HIGH){
    Serial.println("HIGH");
    d=LOW;}
  else{
    Serial.println("LOW");
    d=HIGH;}
  digitalWrite(s4,d);
}
