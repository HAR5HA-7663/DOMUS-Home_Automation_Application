#include <Adafruit_Sensor.h>
#include "DHT.h"
#include <ESP8266WiFi.h>


 
#define WIFI_SSID      
#define WIFI_PASS       
 
#define IO_USERNAME   
#define IO_KEY         

AdafruitIO_WiFi io(IO_USERNAME, IO_KEY, WIFI_SSID, WIFI_PASS);

//dht11
#define DHTPIN 3 
#define DHTTYPE DHT11   // DHT 11


//relay
#define s1 2


//switch
#define p1 10


//button
ButtonConfig config1;
AceButton button1(&config1);


void handleEvent1(AceButton*, uint8_t, uint8_t);


int x = 0;
boolean a;

DHT dht(DHTPIN, DHTTYPE);


AdafruitIO_Feed *temperature = io.feed("temperature");
AdafruitIO_Feed *humidity = io.feed("humidity");
AdafruitIO_Feed *l1 = io.feed("led-1");



void setup() {

  
  pinMode(s1, OUTPUT);



  pinMode(p1, INPUT_PULLUP);

  
  
  Serial.begin(115200);
  dht.begin();
  Serial.print("Connecting to Adafruit IO");
  io.connect();

  l1->onMessage(handleMessage1);




  // acebutton
  config1.setEventHandler(button1Handler);

  
  button1.init(p1);




  while (io.status() < AIO_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.println(io.statusText());


  l1->get();

}


void loop() {
  

  
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

