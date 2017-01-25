var soundEngine = function() {
  this.osc = new maximJs.maxiOsc();
  this.env = envInit();
  this.freq = 440;
  this.amp = 1;
}

soundEngine.prototype.setFreq = function (f) {
  this.freq = f;
};

soundEngine.prototype.setAmp = function (a) {
  this.amp = a;
};

soundEngine.prototype.trigger = function (t) {
  this.env.trigger = t;
};

soundEngine.prototype.getVol = function () {
  return this.env.adsr(1, this.env.trigger);
}

soundEngine.prototype.getOutput = function() {
  return this.osc.sinewave(this.freq) * this.getVol() * this.amp;
}

function envInit() {
  var env = new maximJs.maxiEnv();
  env.setAttack(1);
  env.setDecay(200);
  env.setSustain(0.5);
  env.setRelease(50);
  return env;
}




// function soundEngine() {
//   //envelope
//   this.env = envInit();
//   this.filter = new p5.Filter();
//   this.filter.setType('bandpass');
//   this.filter.freq(500);
//   this.filter.res(1);
//
//   //oscillator1
//   this.osc = new p5.Oscillator();
//   this.osc.setType('sine');
//   this.osc.freq(240);
//   this.osc.disconnect();
//   this.osc.connect(this.filter);
//   this.osc.amp(this.env);
//   this.osc.start();
//
//
//
//
//   this.trigger = function(midi, ampValue) {
//     this.osc.freq(m2f(midi));
//     this.env.play();
//   }
//
//
// }
//
// function m2f (midi) {
//   return 440 * pow(2, (midi - 69) / 12);
// }
//
// function envInit () {
//   var attackLevel = 1.0;
//   var releaseLevel = 0;
//
//   var attackTime = 0.01;
//   var decayTime = 0.2;
//   var susPercent = 0.2;
//   var releaseTime = 0.5;
//
//   var env = new p5.Env;
//   env.setADSR(attackTime, decayTime, susPercent, releaseTime);
//   env.setRange(attackLevel, releaseLevel);
//   return env;
// }
