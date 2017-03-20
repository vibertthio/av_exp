/* global boxes ac AudioSampleLoader */

const loader = new AudioSampleLoader();
loader.src = 'sample/bd.wav';
loader.ctx = ac;

loader.onload = (() => {
  window.mySample = loader.response;
});

loader.onerror = (() => { console.alert('Awww sanp!'); });
loader.send();

const src = ac.createBufferSource();
src.buffer = loader.response;
src.connect(ac.destination);
src.start(0);
