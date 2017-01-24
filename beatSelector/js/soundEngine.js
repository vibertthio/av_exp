function soundEngine() {
  //envelope
  this.env = envInit();
  this.filter = new p5.Filter();
  this.filter.setType('bandpass');
  this.filter.freq(500);
  this.filter.res(1);

  //oscillator1
  this.osc = new p5.Oscillator();
  this.osc.setType('sine');
  this.osc.freq(240);
  this.osc.disconnect();
  this.osc.connect(this.filter);
  this.osc.amp(this.env);
  this.osc.start();




  this.trigger = function(midi, ampValue) {
    this.osc.freq(m2f(midi));
    this.env.play();
  }


}

function m2f (midi) {
  return 440 * pow(2, (midi - 69) / 12);
}

function envInit () {
  var attackLevel = 1.0;
  var releaseLevel = 0;

  var attackTime = 0.01;
  var decayTime = 0.2;
  var susPercent = 0.2;
  var releaseTime = 0.5;

  var env = new p5.Env;
  env.setADSR(attackTime, decayTime, susPercent, releaseTime);
  env.setRange(attackLevel, releaseLevel);
  return env;
}
