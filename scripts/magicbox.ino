#include <dht.h>
#include <ArduinoJson.h>

dht DHT;

#define RELAY_ON 1
#define RELAY_OFF 0

// analog PIN
#define LIGHT_PIN 2
#define VMC_PIN 4
#define FAN_PIN 7
#define PUMP_PIN 8

// digital PIN
#define DHT11_PIN       12



String command;




/* Init */
void setup()
{
  Serial.begin(9600);

  //-------( Initialize Pins so relays are inactive at reset)----
  digitalWrite(LIGHT_PIN, RELAY_OFF);
  digitalWrite(VMC_PIN, RELAY_OFF);
  digitalWrite(FAN_PIN, RELAY_OFF);
  digitalWrite(PUMP_PIN, RELAY_OFF);

  //---( THEN set pins as outputs )----  
  pinMode(LIGHT_PIN, OUTPUT);
  pinMode(VMC_PIN, OUTPUT);
  pinMode(FAN_PIN, OUTPUT);
  pinMode(PUMP_PIN, OUTPUT);
  delay(4000); //Check that all relays are inactive at Reset
}


void loop()
{  
  String command;

  while(Serial.available()) {
    command = Serial.readString();

    if (command.startsWith("COMMAND:")) {      
      runCommand(command);

    } else {
      String error = "{error: 'Unknow command'}";
      Serial.println(error);
    }

    delay(500);
  }
}


/* Core */
void runCommand(String command) {
  // COMMAND FORMAT: COMMAND:ACTION:PIN_NUMBER:VALUE
  String action = getValue(command, ':', 1); // action
  String arg1   = getValue(command, ':', 2); // pin
  String arg2   = getValue(command, ':', 3); // value (0:1)
  
  if (action.equals("DIGITAL_WRITE")) {  
    int pin = arg1.toInt();
    int state = arg2.toInt(); // == 0 ? RELAY_ON : RELAY_OFF;
    
    digitalWrite(pin, state);// set the Relay ON
    delay(1000);
    
    Serial.println("{\"status\": \"OK\"}");
  }
  
  else if (action.equals("READ_SENSORS")) {
    int chk = DHT.read11(DHT11_PIN);

    String jsonStr;
    JsonObject& root = sensorValuesAsJSON();
    root.printTo(jsonStr);
    
    Serial.println(jsonStr);
  }
}





/* Privates */
JsonObject& sensorValuesAsJSON() {
  StaticJsonBuffer<1024> jsonBuffer;
  JsonObject& root = jsonBuffer.createObject();

  temperatureJSON(root);
  humidityJSON(root);
  waterLevelJSON(root);
  soilMoistureJSON(root);

  return root;
}

void temperatureJSON(JsonObject& root){  
  JsonObject& obj = root.createNestedObject("temperature");
  obj["sensor"] = "vma311";
  obj["value"] = DHT.temperature;
  obj["unit"] = "celsius";
}

void humidityJSON(JsonObject& root){
  JsonObject& obj = root.createNestedObject("humidity");
  obj["sensor"] = "vma311";
  obj["value"] = DHT.humidity;
  obj["unit"] = "percent";
}

void waterLevelJSON(JsonObject& root){
  int a0 = analogRead(0);
  JsonObject& obj = root.createNestedObject("water_level");
  obj["sensor"] = "vma303";
  obj["value"] = map(a0, 0, 1024, 0, 100);
  obj["unit"] = "percent";
}

void soilMoistureJSON(JsonObject& root){
  int a1 = analogRead(1);
  int percent = map(a1, 0, 1024, 0, 100);

  JsonObject& obj = root.createNestedObject("soil_moisture");
  obj["sensor"] = "vma303";
  obj["value"] = percent > 0 ? 100 - percent : 0;
  obj["unit"] = "percent";
}



String getValue(String data, char separator, int index)
{
    int found = 0;
    int strIndex[] = { 0, -1 };
    int maxIndex = data.length() - 1;

    for (int i = 0; i <= maxIndex && found <= index; i++) {
        if (data.charAt(i) == separator || i == maxIndex) {
            found++;
            strIndex[0] = strIndex[1] + 1;
            strIndex[1] = (i == maxIndex) ? i+1 : i;
        }
    }
    return found > index ? data.substring(strIndex[0], strIndex[1]) : "";
}