#define A 6
#define B 7
#define C 8
#define D 9

int stepcounter = 0;

void setup()
{
  //Serial.begin(9600);

  pinMode(A,OUTPUT);
  pinMode(B,OUTPUT);
  pinMode(C,OUTPUT);
  pinMode(D,OUTPUT);      
 
  cli();//stop interrupts
  //set timer1 interrupt at 1Hz
  TCCR1A = 0;// set entire TCCR1A register to 0
  TCCR1B = 0;// same for TCCR1B
  TCNT1  = 0;//initialize counter value to 0
  // set compare match register for 1hz increments
  OCR1A = 65;
  // = (16*10^6) / (1*1024) - 1 (must be <65536)
  // turn on CTC mode
  TCCR1B |= (1 << WGM12);
  TCCR1B |= (1 <<CS12);
  // Set CS10 and CS12 bits for 1024 prescaler
  //TCCR1B |= (1 << CS12) | (1 << CS10);  
  // enable timer compare interrupt
  TIMSK1 |= (1 << OCIE1A);
  sei();//allow interrupts
  
}

void stepper(int stepcounter){
  byte pattern = 0B11000001;
  pattern = (pattern << stepcounter) | (pattern >> (8 - stepcounter));

  bool A_state = pattern & 0B10000000;
  bool B_state = pattern & 0B00100000;
  bool C_state = pattern & 0B00001000;
  bool D_state = pattern & 0B00000010;

  digitalWrite(A,A_state);
  digitalWrite(B,B_state);
  digitalWrite(C,C_state);
  digitalWrite(D,D_state);

  /*
  Serial.print("A: ");
  Serial.print(A_state);
  Serial.print(" B: ");
  Serial.print(B_state);
  Serial.print(" C: ");
  Serial.print(C_state);
  Serial.print(" D: ");
  Serial.println(D_state);
  */   
}


ISR(TIMER1_COMPA_vect){
   //Serial.println(stepcounter);
   stepper(stepcounter);
   stepcounter++;
   if (stepcounter >= 8){ stepcounter=0; }
}

void loop(){  }
