window.AudioContext = window.AudioContext || window.webkitAudioContext;
const audioContext = new AudioContext();

const wai = require('web-audio-ios');

wai(document.body, audioContext, function (unlocked) {
  console.log(unlocked, 'yay audio is unlocked now! do yr thing!');
});
