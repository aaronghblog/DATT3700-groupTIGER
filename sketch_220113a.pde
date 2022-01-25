import mqtt.*;
MQTTClient client;

int count = 1;
int meCounter;
int meCounterX;
int meCounterY;

static final String server = "mqtt://datt3700:datt3700experiments@datt3700.cloud.shiftr.io";

void messageReceived(String topic, byte[] payload) {
   //println(topic, int(new String(payload)));  // this is a general print of all topics subscribed to.
   
 if (topic.equals("Processing/Counter/Name")){ //  if topic string is named "whatever" - then set the values received as a float. 
  meCounter = int(new String(payload));
  println("Counter/Name - " + (meCounter)); // print the values
 }
 
  if (topic.equals("Processing/mouse/X-axis")){ //  if topic string is named "whatever" - then set the values received as a float. 
  meCounterX = int(new String(payload));
  println("Processing/mouse/X-axis - " + (meCounterX)); // print the values
  }
  
  if (topic.equals("Processing/mouse/Y-axis")){ //  if topic string is named "whatever" - then set the values received as a float. 
  meCounterY = int(new String(payload));
  println("Processing/mouse/Y-axis - " + (meCounterY)); // print the values
  }
  
}

void settings() {
  size(400, 400);
}

void setup() {
  client = new MQTTClient(this);
  client.connect(server, "Processing");
  client.subscribe("Processing");
  client.subscribe("Processing/Counter/Name");
  client.subscribe("Processing/mouse/X-axis");
  client.subscribe("Processing/mouse/Y-axis");
}

void draw() {
    background(0);
}

void mouseDragged() {
  
   client.publish("Processing/mouse/X-axis", str(meCounterX));
   meCounterX = mouseX;
   client.publish("Processing/mouse/Y-axis", str(meCounterY));
   meCounterY = mouseY;
   
}

void keyPressed(){

  client.publish("Processing/Counter/Name", str(count));
  count++;

}
