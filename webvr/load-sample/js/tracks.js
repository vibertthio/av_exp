/* eslint no-unused-vars: 0 */
/* global allBoxes checkSelected loader*/

/**
 * [bassDrum description]
 * @param  {int} beatNumber [description]
 * @param  {number} time       [description]
 * @param  {audioContext} audioContext [description]
 * @param  {int} controlId       [description]
 */
function bassDrum(beatNumber, time, audioContext, controlId) {
  const boxes = allBoxes[controlId];
  const src = audioContext.createBufferSource();
  src.connect(audioContext.destination);

  if (boxes) {
    const beat = beatNumber % 16;
    const box = boxes[beat];

    // Animation
    box.setAttribute('color', 'red');
    const prev = boxes[(beat > 0) ? (beat - 1) : 15];
    if (!checkSelected(prev)) {
      prev.setAttribute('color', 'white');
    } else {
      prev.setAttribute('color', 'green');
    }

    if (checkSelected(box)) {
      src.buffer = loader.response[0];
      src.start(time);
      src.stop(time + 2);
    }
  }
}

/**
 * [snareDrum description]
 * @param  {int} beatNumber [description]
 * @param  {number} time       [description]
 * @param  {audioContext} audioContext [description]
 * @param  {int} controlId       [description]
 */
function snareDrum(beatNumber, time, audioContext, controlId) {
  const boxes = allBoxes[controlId];
  const src = audioContext.createBufferSource();
  src.connect(audioContext.destination);

  if (boxes) {
    const beat = beatNumber % 16;
    const box = boxes[beat];

    // Animation
    box.setAttribute('color', 'red');
    const prev = boxes[(beat > 0) ? (beat - 1) : 15];
    if (!checkSelected(prev)) {
      prev.setAttribute('color', 'white');
    } else {
      prev.setAttribute('color', 'green');
    }

    if (checkSelected(box)) {
      src.buffer = loader.response[2];
      src.start(time);
      src.stop(time + 2);
    }
  }
}

/**
 * [hihatDrum description]
 * @param  {int} beatNumber [description]
 * @param  {number} time       [description]
 * @param  {audioContext} audioContext [description]
 * @param  {int} controlId       [description]
 */
function hihatDrum(beatNumber, time, audioContext, controlId) {
  const boxes = allBoxes[controlId];
  const src = audioContext.createBufferSource();
  src.connect(audioContext.destination);

  if (boxes) {
    const beat = beatNumber % 16;
    const box = boxes[beat];

    // Animation
    box.setAttribute('color', 'red');
    const prev = boxes[(beat > 0) ? (beat - 1) : 15];
    if (!checkSelected(prev)) {
      prev.setAttribute('color', 'white');
    } else {
      prev.setAttribute('color', 'green');
    }

    if (checkSelected(box)) {
      src.buffer = loader.response[1];
      src.start(time);
      src.stop(time + 2);
    }
  }
}

/**
 * [arpySound description]
 * @param  {int} beatNumber [description]
 * @param  {number} time    [description]
 * @param  {audioContext} audioContext [description]
 * @param  {int} controlId  [description]
 * @param  {int} note       0 ~ 3
 */
function arpySound(beatNumber, time, audioContext, controlId, note) {
  const boxes = allBoxes[controlId];
  console.log('trigger:');
  console.log(controlId);

  if (boxes) {
    const src = audioContext.createBufferSource();
    src.connect(audioContext.destination);

    const beat = beatNumber % 4;
    const box = boxes[beat];

    // Animation
    if (box) {
      box.setAttribute('color', 'red');
      const prev = boxes[(beat > 0) ? (beat - 1) : 3];
      if (!checkSelected(prev)) {
        prev.setAttribute('color', 'white');
      } else {
        prev.setAttribute('color', 'green');
      }

      if (checkSelected(box)) {
        src.buffer = loader.response[note + 3];
        src.start(time);
        src.stop(time + 2);
      }
    }
  }
}
