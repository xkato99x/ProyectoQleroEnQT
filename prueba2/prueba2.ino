int greenDelay = 3500;
int orangeDelay = 1500;
int redDelay = 2000;
int vueltaMil = 2000;


// semaforo1
int vuelta = 5;
int g1Pin = 4;
int o1Pin = 3;
int r1Pin = 2;
//semaforo2
int r2Pin = 13;
int o2Pin = 12;
int g2Pin = 11;
int bot1 = 5;
//semaforo3
int r3Pin = 10;
int o3Pin = 9;
int g3Pin = 8;

int inf1 = 7;

unsigned long greenMillis = 0;
unsigned long orangeMillis = 0;
unsigned long redMillis = 0;
unsigned long vueltaMillis = 0;
unsigned long Error = 0;

unsigned long green2Millis = 0;
unsigned long orange2Millis = 0;
unsigned long red2Millis = 0;

bool vueltaStatus = true;
bool green1Status = true;
bool orange1Status = false;
bool red1Status = false;

bool green2Status = false;
bool orange2Status = false;
bool red2Status = true;

void setup() {
  pinMode(r1Pin, OUTPUT);
  pinMode(o1Pin, OUTPUT);
  pinMode(g1Pin, OUTPUT);
  pinMode(vuelta, OUTPUT);

  pinMode(r2Pin, OUTPUT);
  pinMode(o2Pin, OUTPUT);
  pinMode(g2Pin, OUTPUT);

  pinMode(r3Pin, OUTPUT);
  pinMode(o3Pin, OUTPUT);
  pinMode(g3Pin, OUTPUT);

  pinMode(A0, INPUT);
  pinMode(inf1, INPUT);

  //Inciamos el semaforo con verde en vuelta
  digitalWrite(g1Pin, HIGH);
  digitalWrite(vuelta, HIGH);
  //Luz roja en el otro semaforo
  digitalWrite(r2Pin, HIGH);
  digitalWrite(r3Pin, HIGH);
  Serial.begin(9600);
  Serial.println(" vuelta");
}

int i = 0;
unsigned long tiempoActual = millis();
int cont = 0;

void loop() {

  tiempoActual = millis();

  if (Serial.available()) {

    //Error
    if (Serial.read() == 'e') {
      digitalWrite(vuelta, LOW);
      digitalWrite(g1Pin, LOW);
      digitalWrite(g2Pin, LOW);
      digitalWrite(g3Pin, LOW);
      digitalWrite(r1Pin, LOW);
      digitalWrite(o1Pin, LOW);
      digitalWrite(r2Pin, LOW);
      digitalWrite(o2Pin, LOW);
      digitalWrite(r3Pin, LOW);
      digitalWrite(o3Pin, LOW);

      while (i <= 5) {
        digitalWrite(r1Pin, !digitalRead(r1Pin));
        digitalWrite(o1Pin, !digitalRead(o1Pin));
        digitalWrite(r2Pin, !digitalRead(r2Pin));
        digitalWrite(o2Pin, !digitalRead(o2Pin));
        digitalWrite(r3Pin, !digitalRead(r3Pin));
        digitalWrite(o3Pin, !digitalRead(o3Pin));
        delay(500);
        i++;
      }
      reiniciar();

    }
  }

  //Se presiono el boton
  if (digitalRead(A0) == HIGH) {
    while (digitalRead(A0) == HIGH) {}
    Serial.println('y');
  }
  //Si pasa un carro se envia mensaje
  if (digitalRead(inf1) == HIGH) {
    while (digitalRead(inf1) == HIGH) {}
    cont++;
    String cad = String(cont);
    Serial.println(" " + cad);
  }

  if (tiempoActual - vueltaMillis >= vueltaMil
      && vueltaStatus == true && red2Status == true) {
    Serial.println(" v1");
    greenMillis = millis();
    digitalWrite(vuelta, LOW);
    digitalWrite(r2Pin, LOW);
    digitalWrite(g2Pin, HIGH);
    vueltaStatus = false;
    green1Status = true;

  }

  if (tiempoActual - greenMillis >= greenDelay
      && green1Status == true && red2Status == true) {

    orangeMillis = millis();
    digitalWrite(g1Pin, LOW);
    digitalWrite(g2Pin, LOW);
    green1Status = false;

    digitalWrite(o1Pin, HIGH);
    digitalWrite(o2Pin, HIGH);
    orange1Status = true;

  }

  if (tiempoActual - orangeMillis >= orangeDelay && orange1Status == true) {

    redMillis = millis();
    digitalWrite(o1Pin, LOW);
    digitalWrite(o2Pin, LOW);
    orange1Status = false;

    digitalWrite(r1Pin, HIGH);
    digitalWrite(r2Pin, HIGH);
    red1Status = true;

    //enciende semaforo de arriba
    digitalWrite(r3Pin, LOW);
    red2Status = false;
    digitalWrite(g3Pin, HIGH);
    green2Status = true;
    green2Millis = millis();
    Serial.println(" v2");
  }

  if (tiempoActual - green2Millis >= greenDelay
      && green2Status == true) {

    orange2Millis = millis();
    digitalWrite(g3Pin, LOW);
    green2Status = false;

    digitalWrite(o3Pin, HIGH);
    orange2Status = true;
  }

  if (tiempoActual - orange2Millis >= orangeDelay
      && orange2Status == true) {
    red2Millis = millis();
    digitalWrite(o3Pin, LOW);
    orange2Status = false;

    digitalWrite(r3Pin, HIGH);
    red2Status = true;
  }

  if (tiempoActual - redMillis >= redDelay
      && red1Status == true && red2Status == true) {
    Serial.println(" vuelta");
    vueltaMillis = millis();
    digitalWrite(r1Pin, LOW);
    red1Status = false;

    digitalWrite(vuelta, HIGH);
    digitalWrite(g1Pin, HIGH);
    vueltaStatus = true;
  }

}

void reiniciar() {

  tiempoActual = 0;
  greenMillis = 0;
  orangeMillis = 0;
  redMillis = 0;
  vueltaMillis = 0;

  green2Millis = 0;
  orange2Millis = 0;
  red2Millis = 0;
  i = 0;

  vueltaStatus = true;
  green1Status = true;
  orange1Status = false;
  red1Status = false;

  green2Status = false;
  orange2Status = false;
  red2Status = true;

  digitalWrite(vuelta, HIGH);
  digitalWrite(g1Pin, HIGH);

  digitalWrite(r2Pin, HIGH);
  digitalWrite(r3Pin, HIGH);
}
