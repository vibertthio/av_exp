class TimeLine {
  boolean state;
  int localtime;
  int limit;
  int elapsedTime;
  int repeatTime = 1;
  boolean breathState = false;
  boolean loop = false;

  float linerRate = 1;

  TimeLine(int sec) {
    limit=sec;
    state=false;
  }

  TimeLine(int sec, boolean _loop) {
    limit = sec;
    loop = _loop;
    state = _loop;
  }
  void update() {
    if (state == true) {
      elapsedTime = currentTime() - localtime;

      if (elapsedTime>int(limit)) {
        if( !loop ) {
          elapsedTime = int(limit);
          state=false;
        }
        else {
          startTimer();
        }
      }
    }
  }

  float liner() {
    update();
    float t = float(elapsedTime)/limit;
    float ret = pow(t, linerRate);
    return min(1, ret);
  }
  float getPowIn(float pow) {
    update();
    float t = float(elapsedTime)/limit;
    float ret = pow(t, pow);
    return min(1, ret);
  }
  float getPowOut(float pow) {
    update();
    float t = float(elapsedTime)/limit;
    float ret = 1 - pow(1 - t, pow);
    return min(1, ret);
  }
  float getPowInOut(float pow) {
    update();
    float t = float(elapsedTime)/limit;
    float ret;
    if ((t*=2)<1) {
      ret = 0.5 * pow(t, pow);
    }
    else {
      ret = 1 - 0.5 * abs(pow(2-t, pow));
    }

    return min(1, ret);
  }
  float sineIn() {
    update();
    float t = float(elapsedTime)/limit;
    return min(1, 1 - cos(t * PI / 2));
  }
  float sineOut() {
    update();
    float t = float(elapsedTime)/limit;
    return min(1, sin(t * PI / 2));
  }
  float sineInOut() {
    update();
    float t = float(elapsedTime)/limit;
    return min(1, 0.5*(1 - cos(PI*t)));
  }
  float getBackIn(float amount) {
    update();
    float t = float(elapsedTime)/limit;
    return t*t*((amount+1)*t-amount);
  }
  float getBackOut(float amount) {
    update();
    float t = float(elapsedTime)/limit;
    return (--t*t*((amount+1)*t + amount) + 1);
  }
  float getBackInOut(float amount) {
    update();
    float t = float(elapsedTime)/limit;
    if ((t*=2)<1) {
      return 0.5*(t*t*((amount+1)*t-amount));
    }
    else {
      return 0.5*((t-=2)*t*((amount+1)*t+amount)+2);
    }
  }
  float circIn() {
    update();
    float t = float(elapsedTime)/limit;
    return (1 - sqrt(1-t*t));
  }
  float circOut() {
    update();
    float t = float(elapsedTime)/limit;
    return sqrt(1-(--t)*t);
  }
  float circInOut() {
    update();
    float t = float(elapsedTime)/limit;
    if ((t*=2) < 1) {
      return -0.5*(sqrt(1-t*t)-1);
    }
    else {
      return 0.5*(sqrt(1-(t-=2)*t)+1);
    }
  }
  float bounceIn() {
    update();
    float t = float(elapsedTime)/limit;
    return 1 - bo(1-t);
  }
  float bounceOut() {
    update();
    float t = float(elapsedTime)/limit;
    return bo(t);
  }
  float bounceInOut() {
    update();
    float t = float(elapsedTime)/limit;
    if (t<0.5) {
      return (1-bo(1-t*2))*0.5;
    }
    else {
      return bo(t*2-1)*0.5+0.5;
    }
  }
  float bo(float t) {
    if (t < 1/2.75) {
			return (7.5625*t*t);
		} else if (t < 2/2.75) {
			return (7.5625*(t-=1.5/2.75)*t+0.75);
		} else if (t < 2.5/2.75) {
			return (7.5625*(t-=2.25/2.75)*t+0.9375);
		} else {
			return (7.5625*(t-=2.625/2.75)*t +0.984375);
		}
  }
  float elasticIn() {
    update();
    float t = float(elapsedTime)/limit;
    float b = 0;
    float c = 1;
    float d = 1;
    if (t == 0)
      return b;
    if ((t /= d) == 1)
      return b + c;
    float p = d * .3f;
    float a = c;
    float s = p / 4;
    return -(a * (float) Math.pow(2, 10 * (t -= 1)) * (float) Math.sin((t * d - s) * (2 * (float) Math.PI) / p)) + b;
  }
  float elasticOut() {
    update();
    float t = float(elapsedTime)/limit;
    float b = 0;
    float c = 1;
    float d = 1;
    if (t == 0)
      return b;
    if ((t /= d) == 1)
      return b + c;
    float p = d * .3f;
    float a = c;
    float s = p / 4;
    return (a * (float) Math.pow(2, -10 * t) * (float) Math.sin((t * d - s) * (2 * (float) Math.PI) / p) + c + b);
  }
  float elasticInOut() {
    update();
    float t = float(elapsedTime)/limit;
    float b = 0;
    float c = 1;
    float d = 1;
    if (t == 0)
      return b;
    if ((t /= d / 2) == 2)
      return b + c;
    float p = d * (.3f * 1.5f);
    float a = c;
    float s = p / 4;
    if (t < 1)
      return -.5f * (a * (float) Math.pow(2, 10 * (t -= 1)) * (float) Math.sin((t * d - s) * (2 * (float) Math.PI) / p)) + b;
    return a * (float) Math.pow(2, -10 * (t -= 1)) * (float) Math.sin((t * d - s) * (2 * (float) Math.PI) / p) * .5f + c + b;
  }

  // float getElasticIn(float amp, float period) {
  //   update();
  //   float t = float(elapsedTime)/limit;
  //   if (t==0 || t==1) {
  //     return t;
  //   }
  //   float s = period/(PI*2*asin(1/amp));
  //   return -(amp*pow(2,10*(t-=1))*sin((t-s)*PI*2/period));
  // }
  // float getElasticOut(float amp, float period) {
  //   update();
  //   float t = float(elapsedTime)/limit;
  //   if (t==0 || t==1) {
  //     return t;
  //   }
  //   float s = period/(PI*2*asin(1/amp));
  //   return (amp*pow(2,-10*t)*sin((t-s)*PI*2/period )+1);
  // }
  // float getElasticInOut(float amp, float period) {
  //   update();
  //   float t = float(elapsedTime)/limit;
  //   if (t==0 || t==1) {
  //     return t;
  //   }
  //   float s = period/(PI*2*asin(1/amp));
	// 	if ((t*=2)<1) return -0.5*(amp*pow(2,10*(t-=1))*sin( (t-s)*PI*2/period ));
	// 	return amp*pow(2,-10*(t-=1))*sin((t-s)*PI*2/period)*0.5+1;
  // }

  float repeatBreathMovement() {
    if (state == true) {
      //println("check!!!!");
      elapsedTime = currentTime() - localtime;
      if (elapsedTime>int(limit)) {
        elapsedTime = int(limit);
        if(repeatTime < 2 && breathState) {
          state = false; }
        else {
          if(breathState == true) {
            repeatTime-- ;
          }
          breathState = !breathState;
          startTimer();
        }
      }
    }

    float t = float(elapsedTime)/limit;
    if(!breathState) {
      return pow(t, linerRate); }
    else {
      return pow((1-t), linerRate); }
  }
  float repeatBreathMovementEndless() {
    if (state == true) {
      //println("check!!!!");
      elapsedTime = currentTime() - localtime;
      if (elapsedTime>int(limit)) {
        elapsedTime = int(limit);
        if(repeatTime < 1 && breathState) {
          state = false; }
        else {
          breathState = !breathState;
          startTimer();
        }
      }
    }

    float t = float(elapsedTime)/limit;
    if(!breathState) {
      return pow(t, linerRate); }
    else {
      return pow((1-t), linerRate); }
  }
  void setLinerRate(float r) { linerRate = r; }
  void setRepeatTime(int t) { repeatTime = t; }
  boolean startTimer() {
    if (state == true) {
      localtime = currentTime();
      elapsedTime = 0;
      return false;
    }
    else {
      localtime = currentTime();
      state=true;
      elapsedTime = 0;
      return true;
    }
  }
  void turnOffTimer() {
    localtime = currentTime() - limit;
    state = false;
  }

  int currentTime() {
    return millis();
  }
  void setLoop() { loop = true; }
  void set1() { elapsedTime = limit; }
}
