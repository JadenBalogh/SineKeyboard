import processing.sound.*;

SinInstrument sinInstrument;
SquareInstrument squareInstrument;
PadInstrument padInstrument;
ParticleSystem particleSystem;

void setup()
{
  size(200, 200);

  //Have to use built-in Processing keyCodes
  //Print out keyCode on keyPressed() to figure out
  //the code for each key
  sinInstrument = new SinInstrument(
    new SinNote(C4, 49), //1
    new SinNote(Cs4, 81), //q
    new SinNote(D4, 50), //2
    new SinNote(Ds4, 87), //w
    new SinNote(E4, 51), //3
    new SinNote(F4, 52), //4
    new SinNote(Fs4, 82), //r
    new SinNote(G4, 53), //5
    new SinNote(Gs4, 84), //t
    new SinNote(A4, 54), //6
    new SinNote(As4, 89), //y
    new SinNote(B4, 55), //7
    new SinNote(C5, 56), //8
    new SinNote(Cs5, 73), //i
    new SinNote(D5, 57), //9
    new SinNote(Ds5, 79), //o
    new SinNote(E5, 48) //0
    );

  squareInstrument = new SquareInstrument( 
    new SquareNote(C4, 65), //a
    new SquareNote(Cs4, 90), //z
    new SquareNote(D4, 83), //s
    new SquareNote(Ds4, 88), //x
    new SquareNote(E4, 68), //d
    new SquareNote(F4, 70), //f
    new SquareNote(Fs4, 86), //v
    new SquareNote(G4, 71), //g
    new SquareNote(Gs4, 66), //b
    new SquareNote(A4, 72), //h
    new SquareNote(As4, 78), //n
    new SquareNote(B4, 74), //j
    new SquareNote(C5, 75), //k
    new SquareNote(Cs5, 44), //,
    new SquareNote(D5, 76), //l
    new SquareNote(Ds5, 46), //.
    new SquareNote(E5, 59) //;
    );

  //keyCode for pad #'s (0-9) are 96-105
  padInstrument = new PadInstrument(
    new Sound("Hi-hat.wav", 103), 
    new Sound("Snare.wav", 104), 
    new Sound("Kick.wav", 105)
    );

  //String spriteFilepath, int particleSize, float emissionRate, float maxScale, float spawnOriginX, float spawnOriginY, 
  //                      float spawnRangeX, float spawnRangeY, float minVelocity, float maxVelocity,
  //                      float minLifetime, float maxLifetime
  particleSystem = new ParticleSystem("Particle.png", 10, 200, 0.1, width/2, height/2, 0, 0, 3, 5, 1, 1);
}

void draw()
{
  Timer.update(millis());   
  background(0);

  if (keyPressed && !particleSystem.isActive())
    particleSystem.setActive(true);
  else if (particleSystem.isActive())
    particleSystem.setActive(false);

  particleSystem.update();
  drawVisuals();
}

void keyPressed()
{
  //println(keyCode);
  sinInstrument.play();
  squareInstrument.play();
  padInstrument.play();
  flash();
  bounce();
}

void keyReleased()
{
  sinInstrument.stop();
  squareInstrument.stop();
  padInstrument.stop();
}
