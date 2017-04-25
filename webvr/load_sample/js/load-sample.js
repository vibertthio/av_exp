/* global boxes ac AudioSampleLoader */

const loader = new AudioSampleLoader();
loader.src = ['sample/bd.wav', 'sample/hh.wav', 'sample/sn.wav'];
loader.ctx = ac;

loader.onload = (() => {
  window.mySample = loader.response;

  //test
  const samples = [];
  for (let i = 0; i < 3; i += 1) {
    samples[i] = ac.createBufferSource();
    samples[i].buffer = loader.response[i];
    samples[i].connect(ac.destination);
    samples[i].start(i);
    samples[i].stop(i + 1);
  }
});

loader.onerror = (() => { console.alert('Awww sanp!'); });
loader.send();
