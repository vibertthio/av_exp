var maximJs;
var audio = new maximJs.maxiAudio();
audio.init();

var clk = new maximJs.maxiClock();
clk.setTicksPerBeat(4);
clk.setTempo(60);

var se = new soundEngine();
var se2 = new soundEngine();

audio.play = function() {
  clk.ticker();
  if (clk.tick) {
    console.log("tick!");
    updateSquares();

    //sound1
    se.trigger(1);
    se.setFreq(m2f(midi(squares[0])));
    se.setAmp(amp(squares[1]));

    //sound2
    se2.trigger(1);
    se2.setFreq(m2f(midi(squares[2])));
    se2.setAmp(amp(squares[3]));
  }
  else {
    se.trigger(0);
    se2.trigger(0);
  }

  var o = se.getOutput() * 0.5 + se2.getOutput() * 0.5;
  this.output = o * 0.5;
}
