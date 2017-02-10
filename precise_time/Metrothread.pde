class MetroThread extends Thread {

  long previousTime;
  double bpm;
  double delta;
  double interval;

  MetroThread(double _bpm) {
    bpm = _bpm;
    interval = 1000.0 / (bpm / 60.0);
    delta = 0.05 * interval;
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
        // TODO

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
    }
  }
}
