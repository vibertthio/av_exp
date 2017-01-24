function Metro(ss, ll) {
  this.state = ss;
  this.elapsedTime;
  this.localtime = millis();
  this.limit = ll;
  this.timeInterval = 0;

  this.frameCount = function() {
    if (this.state) {
      return floor ( (this.currentTime() - this.localtime) / this.limit );
    }
    else {
      return floor ( this.timeInterval / this.limit );
    }
  }

  this.startPlayingAt = function(fc) {
    if (this.state) {
      this.stopAndReset();
    }
    this.state = true;
    this.localtime = this.currentTime() - fc * this.limit;
  }

  this.pause = function() {
    if (state) {
      this.state = false;
      this.timeInterval = this.currentTime() - this.localtime;
    }
  }

  this.stopAndReset = function() {
    this.state = false;
  }

  this.currentTime = function() {
    return millis();
  }
}
