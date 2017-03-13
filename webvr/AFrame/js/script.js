// const sky = document.getElementsByClassName('sky')[0];
const ascene = document.getElementsByClassName('scene')[0];

/**
 * Create a-box item.
 * @param {number} x the x of position.
 * @param {number} y the y of position.
 * @param {number} z the z of position.
 * @return {Element} a-box item.
 */
function createNewBox(x, y, z) {
  const b = document.createElement('a-box');
  b.setAttribute('class', 'box');
  b.setAttribute('src', '#textureOfBox');
  b.setAttribute('opacity', '1');
  b.setAttribute('scale', '1 1 1');
  b.setAttribute('position', `${x} ${y} ${z}`);
  b.setAttribute('rotation', '0 0 45');
  // b.setAttribute('rotation', '0 45 45');
  b.innerHTML = '<a-animation attribute="scale" begin="mouseenter" dur="300" to="1.1 1.1 1.1"></a-animation>'
    + '<a-animation attribute="scale" begin="mouseleave" dur="300" to="1 1 1"></a-animation>'
  ;
  // b.innerHTML = '<a-animation attribute="position" to="0 2.2 -5"
  //                direction="alternate" dur="2000" repeat="indefinite"></a-animation>'
  //   + '<a-animation attribute="scale" begin="mouseenter"
  //      dur="300" to="1.3 1.3 1.3"></a-animation>'
  //   + '<a-animation attribute="scale" begin="mouseleave" dur="300" to="1 1 1"></a-animation>'
  // ;
  return b;
}

const boxes = [];
for (let i = 0; i < 4; i += 1) {
  for (let j = 0; j < 4; j += 1) {
    const newBox = createNewBox(-6 + (4 * i), 1 + (2 * j), -8);
    boxes[(i * 4) + j] = newBox;
    ascene.appendChild(newBox);
  }
}

// ascene.addEventListener('click', () => {
//   // const newBox = createNewBox(0, 2, -5);
//   const newBox = createNewBox((Math.random() * 4) - 2,
//                               (Math.random() * 2) - 1,
//                               -10);
//   ascene.appendChild(newBox);
// });
