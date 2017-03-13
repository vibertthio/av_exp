/* global maximJs boxes*/
/* eslint new-cap: ["error", { "newIsCap": false }] */

const audio = new maximJs.maxiAudio();
audio.init();

const osc = new maximJs.maxiOsc();
const clk = new maximJs.maxiClock();
const env = new maximJs.maxiEnv();

const sequence = [
  100, 200, 400, 200,
  120, 440, 300, 270,
  100, 200, 400, 200,
  120, 440, 300, 270,
];

clk.setTicksPerBeat(4);
clk.setTempo(60);

env.setAttack(1);
env.setDecay(200);
env.setSustain(0.5);
env.setRelease(50);


audio.play = function loop() {
  clk.ticker();
  const vol = env.adsr(1, env.trigger);

  if (clk.tick) {
    env.trigger = 1;
    const beat = clk.playHead % 16;
    const thisBox = boxes[beat];
    thisBox.setAttribute('color', 'red');
    if (beat > 0) {
      boxes[beat - 1].setAttribute('color', 'white');
    } else {
      boxes[15].setAttribute('color', 'white');
    }
  } else {
    env.trigger = 0;
  }

  const input = osc.sinewave(sequence[clk.playHead % sequence.length]);
  this.output = input * vol * 0.1;
};
