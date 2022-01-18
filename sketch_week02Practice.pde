import mqtt.*;

MQTTClient client;
int count = 1;
int meCounter = 1;

static final String server = "mqtt://datt3700tiger:rtdDVutDr035iJ3u@datt3700tiger.cloud.shiftr.io";

void settings(){
  size(200,200);
}

void messageReceived(String topic, byte[] payload) {
  if (topic.equals("/Aaron/Counter")){      // if topic string is named "someName" then set the values received as a float
      meCounter = int(new String(payload));
      println("/Aaron/Counter - " + (meCounter));
  }
}

void setup() {
  client = new MQTTClient(this);
  client.connect(server, "Aaron-Process");
  client.subscribe("/Aaron/Counter");
  client.subscribe("/Aaron/topic");
}

void draw() {
  background(0);
}

//publish
void keyPressed() {
  client.publish("/Aaron/Counter", str(count));
  count++;
}

void mouseDragged() {
  client.publish("/Aaron/MouseX");
  client.publish("/Aaron/MouseY");
}
