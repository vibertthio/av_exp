// In the requirement of application of musical sequencer, midi control..
// the highest bpm is probably between 400 ~ 1000
// and the standard of midi clk is 24 ticks per beat
// therefore, the highest resolution goes to 400 * 24


MidiThread midi;
int bpm = 9600;
double timeStep = 1000.0 / (bpm / 60.0);
double delta = 0.05 * timeStep;


void setup() {
  size(100,100);

  println("bpm: " + bpm);
  println("time interval: " + timeStep);
  midi=new MidiThread(9600);
  midi.start();

}

void draw() {
        // do whatever
}


class MidiThread extends Thread {

  long previousTime;
  double interval;

  MidiThread(double bpm) {
    // interval currently hard coded to quarter beats
    interval = 1000.0 / (bpm / 60.0);
    // println("interval : " + interval);
    previousTime=System.nanoTime();
  }

  void run() {
    try {
      while(!Thread.currentThread().isInterrupted()) {
        // calculate time difference since last beat & wait if necessary
        double timePassed=(System.nanoTime()-previousTime)*1.0e-6;
        while(timePassed<interval) {
                timePassed=(System.nanoTime()-previousTime)*1.0e-6;
        }
        // insert your midi event sending code here
        // println("midi out: "+timePassed+"ms");

        //test
        if ((timePassed - timeStep)*(timePassed - timeStep) > delta*delta) {
          // println("midi out: "+timePassed+"ms");
          println("er: "+ (timePassed - timeStep) +"ms");
        }

        // calculate real time until next beat
        long delay=(long)(interval-(System.nanoTime()-previousTime)*1.0e-6);
        previousTime=System.nanoTime();
        if (delay > 0) {
          Thread.sleep(delay);
        }
      }
    }
    catch(Exception e) {
      println(e.getMessage());
      println("force quit...");
    }
  }
}
