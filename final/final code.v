#include <LiquidCrystal.h>

#include <SimpleDHT.h>
#define  DHT_PIN A7
SimpleDHT11 dht11(DHT_PIN);
LiquidCrystal lcd(7, 6, 5, 4, 3, 2);

int sensorPin = A0;
int motorPin1 = A1;
int motorPin2 = A2;
int T;
int H ;
int sensorValue = 0;
int percentValue = 0;


void setup() {
  Serial.begin(9600);
  lcd.begin(16, 2);
  pinMode(motorPin1, OUTPUT);
    pinMode(motorPin2, OUTPUT);
}
  

void loop() {
   delay(1000);
  sensorValue = analogRead(sensorPin);
  Serial.print("\n\nAnalog Value: ");
  Serial.print(sensorValue);
  
  percentValue = map(sensorValue, 1023, 200, 0, 100);
  Serial.print("\nPercentValue: ");
  Serial.print(percentValue);
  Serial.print("%");
  byte temperature=0  ;
  byte humidity=0;

  dht11.read(&temperature, &humidity, 0);
  T = ((int)temperature);
  H = ((int)humidity);

  Serial.print("  Temperature = ");
  Serial.println(T);
  Serial.print("Humidity = ");
  Serial.println(H);
    if( percentValue <= 50 ){
     analogWrite(motorPin1, 255);
     analogWrite(motorPin2, 0);
   lcd.setCursor(0, 0);
  lcd.print("Soil Moisture");
  
  lcd.setCursor(0, 1);  
  lcd.print("Percent: ");
  lcd.print(percentValue);
  lcd.print("%");
  delay(2000);
  lcd.clear();
  lcd.print("motor is on");
  delay(2000);
   lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Temp: ");
  lcd.print(T); 
  lcd.print("'C");
  
  lcd.setCursor(0,1);
  lcd.print("Humid: ");
  lcd.print(H);
  lcd.print("%");
  delay(2000);
    }
    else
    {
        analogWrite(motorPin1, 0);
     analogWrite(motorPin2, 0);
       lcd.setCursor(0, 0);
  lcd.print("Soil Moisture");
  
  lcd.setCursor(0, 1);  
  lcd.print("Percent: ");
  lcd.print(percentValue);
  lcd.print("%");
  delay(2000);
  lcd.clear();
  lcd.print("motor is off");
  delay(2000);
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Temp: ");
  lcd.print(T); 
  lcd.print("'C");
  
  lcd.setCursor(0,1);
  lcd.print("Humid: ");
  lcd.print(H);
  lcd.print("%");
  delay(2000);
    }
}
