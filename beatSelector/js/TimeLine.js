function TimeLine(ll) {
  this.currentTime = function() {
    return millis();
  }

  this.state = false;
  this.limit = ll;
  this.linerRate = 1.0;
  this.localTime = this.currentTime();
  this.elapsedTime = 0;

  this.startTimer = function() {
    this.localTime = this.currentTime();
    this.elapsedTime = 0;
    if (this.state) {
      return false;
    }
    else {
      this.state = true;
      return true;
    }
  }

  this.liner = function() {
    if (this.state) {
      this.elapsedTime = this.currentTime() - this.localTime;
    }

    var ret = Math.min(
                Math.pow( this.elapsedTime / this.limit,
                          this.linerRate), 1);
    return ret;
  }

  this.setLinerRate = function(r) {
    this.linerRate = r;
  }

  this.set1 = function() {
    this.elapsedTime = this.limit;
  }

}
