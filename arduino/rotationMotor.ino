#include "WiFiEsp.h"
#include <Servo.h>
Servo myservo;
#ifndef HAVE_HWSERIAL1

#endif

#include "SoftwareSerial.h"

SoftwareSerial Serial1(2, 3); // RX, TX



char ssid[] = "KT_GiGA_2G_01DF";            // your network SSID (name)

char pass[] = "2ggd1cz418";        // your network password

int status = WL_IDLE_STATUS;     // the Wifi radio's status


char server[] = "119.196.239.86"; 



// Initialize the Ethernet client object

WiFiEspClient client;



void setup()

{

  // initialize serial for debugging

  Serial.begin(9600);
  myservo.attach(9);
  Serial1.begin(9600);
  WiFi.init(&Serial1);



  // check for the presence of the shield

  if (WiFi.status() == WL_NO_SHIELD) {

    Serial.println("WiFi shield not present");

    // don't continue

    while (true);

  }

  // attempt to connect to WiFi network

  while ( status != WL_CONNECTED) {

    Serial.print("Attempting to connect to WPA SSID: ");

    Serial.println(ssid);

    // Connect to WPA/WPA2 network

    status = WiFi.begin(ssid, pass);

  }



  // you're connected now, so print out the data

  Serial.println("You're connected to the network");

  

  printWifiStatus();



  Serial.println();

  Serial.println("Starting connection to server...");

  // if you get a connection, report back via serial

  if (client.connect(server, 8080)) {

    Serial.println("Connected to server");

    // Make a HTTP request
    client.println("GET /test.txt HTTP/1.1");
    client.println("Host: 119.196.239.86");
    client.println("User-Agent: launchpad-wifi");
    client.println("Connection: close");

    client.println();

  }

}



void loop()

{

  // if there are incoming bytes available

  // from the server, read them and print them

  while (client.available()) {

    char c = client.read();
    if(c=='a'){
      myservo.write(90);
      delay(1000);
    }
    else if(c=='b'){
      myservo.write(135);
      delay(1000);
    }
    else if(c=='c'){
      myservo.write(180);
      delay(1000);
    }
    else if(c=='d'){
      myservo.write(45);
      delay(1000);
    }
    else if(c=='e'){
      myservo.write(0);
      delay(1000);
    }
    
   // Serial.write(c);

  }



  // if the server's disconnected, stop the client

  if (!client.connected()) {

    Serial.println();

    Serial.println("Disconnecting from server...");

    client.stop();
    // do nothing forevermore

    while (true);

  }

}




void printWifiStatus()

{

  // print the SSID of the network you're attached to

  Serial.print("SSID: ");

  Serial.println(WiFi.SSID());



  // print your WiFi shield's IP address

  IPAddress ip = WiFi.localIP();

  Serial.print("IP Address: ");

  Serial.println(ip);



  // print the received signal strength

  long rssi = WiFi.RSSI();

  Serial.print("Signal strength (RSSI):");

  Serial.print(rssi);

  Serial.println(" dBm");

}
