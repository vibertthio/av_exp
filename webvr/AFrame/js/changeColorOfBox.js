const boxes = document.getElementsByClassName('box');


// let clicked = false;
// const changeColor = (e) => {
//   const b = e.target;
//   if (!clicked) {
//     b.setAttribute('color', 'green');
//   } else {
//     b.setAttribute('color', 'white');
//   }
//   clicked = !clicked;
// };

const changeColor = (e) => {
  const b = e.target;
  const ifSelected = b.classList.toggle('selected');
  if (ifSelected) {
    b.setAttribute('color', 'green');
  } else {
    b.setAttribute('color', 'white');
  }
};

for (let i = 0, n = boxes.length; i < n; i += 1) {
  const box = boxes[i];
  box.addEventListener('click', changeColor);
  box.addEventListener('touchstart', changeColor);
}
