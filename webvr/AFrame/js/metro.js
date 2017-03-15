/* global boxes checkSelected ac */
const notesInQueue = [];      // the notes that have been put into the web audio,

/**
* Constructor function for Metro object.
* @param {AudioContext} ac the global audio context.
*/
function Metro(ac) {
  /** Data Members **/

  // Constants
  this.audioContext = ac;
  this.lookahead = 25.0;       // How frequently to call scheduling function
  this.scheduleAheadTime = 0.1;    // How far ahead to schedule audio (sec)
  this.noteLength = 0.05;      // length of "beep" (in seconds)

  // Variables
  this.isPlaying = false;
  this.timerID = null;
  this.current16thNote = 0;        // What note is currently last scheduled?
  this.nextNoteTime = 0.0;     // when the next note is due.

  // Public Variables
  this.tempo = 120.0;          // tempo (in beats per minute)
  this.noteResolution = 0;     // 0 == 16th, 1 == 8th, 2 == quarter note


  //
  const osc = this.audioContext.createOscillator();
  osc.connect(this.audioContext.destination);
  osc.frequency.value = 1000.0;
  const t = this.audioContext.currentTime;
  osc.start(t);
  osc.stop(t+0.5);

  /** Methods **/

  /**
  * Play
  * @return {void}
  */
  this.play = () => {
    // console.log(`timerID: ${this.timerID}`);
    this.isPlaying = !this.isPlaying;

    if (this.isPlaying) { // start playing
      this.current16thNote = 0;
      this.nextNoteTime = this.audioContext.currentTime;
        // timerWorker.postMessage("start");
      // console.log(`start!
      //              lookahead: ${this.lookahead}`);

      this.timerID = setInterval(this.scheduler, this.lookahead);

      return 'stop';
    } else {
      console.log('stop!!!!!');
      clearInterval(this.timerID);
      this.timerID = null;
      return 'play';
    }
  };

  /**
  * Set the variable for the next note.
  * @return {void}
  */
  this.nextNote = () => {
    // Advance current note and time by a 16th note...
    const secondsPerBeat = 60.0 / this.tempo;    // Notice this picks up the CURRENT
                                          // tempo value to calculate beat length.
    this.nextNoteTime += 0.25 * secondsPerBeat;    // Add beat length to last beat time

    this.current16thNote += 1;    // Advance the beat number, wrap to zero
    if (this.current16thNote === 16) {
      this.current16thNote = 0;
    }
  };

  /**
  * ScheduleNote, insert the TODO commands here.
  * @param {number} beatNumber
  * @param {number} time
  * @return {void}
  */
  this.scheduleNote = (beatNumber, time) => {
    // push the note on the queue, even if we're not playing.
    notesInQueue.push({ note: beatNumber, time });

    if ((this.noteResolution === 1) && (beatNumber % 2)) { return; }
    if ((this.noteResolution === 2) && (beatNumber % 4)) { return; }

    // create an oscillator
    const osc = this.audioContext.createOscillator();
    osc.connect(this.audioContext.destination);

    /**
    * TODO
    * Insert the action here.
    */
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

      // Beat
      if (checkSelected(box)) {
        if (beat === 0) {
          osc.frequency.value = 880.0;
        } else if (beat % 4 === 0) {
          osc.frequency.value = 440.0;
        } else {
          osc.frequency.value = 220.0;
        }

        osc.start(time);
        osc.stop(time + this.noteLength);
      }
    }
  };

  /**
  * Scheduler
  * @return {void}
  */
  this.scheduler = () => {
    // while there are notes that will need to play before the next interval,
    // schedule them and advance the pointer.
    while (this.nextNoteTime < this.audioContext.currentTime + this.scheduleAheadTime) {
      this.scheduleNote(this.current16thNote, this.nextNoteTime);
      this.nextNote();
    }
  };

  /**
  * Draw
  * @return {void}
  */
  this.draw = () => {};
}

const metro = new Metro(ac);
metro.play();
