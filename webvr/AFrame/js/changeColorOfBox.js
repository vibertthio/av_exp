/* global boxes*/
/* no-unused-vars: 'off' */

const bs = document.getElementsByClassName('box');

/**
* Check if the box is triggered.
* @param {object} b this a-box object
* @return {boolean} true for triggered, vice versa.
*/
function checkSelected(b) {
  return b.classList.contains('selected');
}

const changeColor = (e) => {
  const b = e.target;
  b.classList.toggle('selected');
  console.warn('changing color!');
  if (checkSelected(b)) {
    b.setAttribute('color', 'green');
  } else {
    b.setAttribute('color', 'white');
  }
};

for (let i = 0, n = bs.length; i < n; i += 1) {
  const box = bs[i];
  box.addEventListener('click', changeColor);
  box.addEventListener('touchstart', changeColor);
}
