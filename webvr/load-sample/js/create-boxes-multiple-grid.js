// const sky = document.getElementsByClassName('sky')[0];
const ascene = document.getElementsByClassName('scene')[0];

/**
 * Create a-box item.
 * @param {number} x the x of position.
 * @param {number} y the y of position.
 * @param {number} z the z of position.
 * @param {number} angle the rotation of y-axis.
 * @param {number} size the size of cube.
 * @return {Element} a-box item.
 */
function createNewBox(x, y, z, angle = 0, size = 0.5) {
  const b = document.createElement('a-box');
  b.setAttribute('class', 'box');
  b.setAttribute('src', '#textureOfBox');
  b.setAttribute('opacity', '1');
  b.setAttribute('scale', `${size} ${size} ${size}`);
  b.setAttribute('position', `${x} ${y} ${z}`);
  b.setAttribute('rotation', `0 ${angle} 45`);

  b.innerHTML = `<a-animation
                   attribute="position"
                   to="${x + (Math.random() * 0.5)} ${y - (Math.random() * 0.5)} ${z + (Math.random() * 0.5)}"
                   direction="alternate"
                   dur="${(Math.random() * 500) + 1000}"
                   repeat="indefinite">
                 </a-animation>
                 <a-animation
                   attribute="scale"
                   begin="mouseenter"
                   dur="300"
                   to="${size * 1.2} ${size * 1.2} ${size * 1.2}">
                 </a-animation>'
                 <a-animation
                   attribute="scale"
                   begin="mouseleave"
                   dur="300"
                   to="${size} ${size} ${size}">
                 </a-animation>`
  ;
  return b;
}

// const numberOfLayers = 3;
const numberOfBoxes = 16;
const allBoxes = [];

// drums
for (let k = 0; k < 7; k += 1) {
  allBoxes[k] = [];
  if (k < 3) {
    for (let i = 0; i < numberOfBoxes; i += 1) {
      const newBox = createNewBox(-7.5 + (1.0 * i), 1 + (1.0 * k), -8);
      allBoxes[k][i] = newBox;
      ascene.appendChild(newBox);
    }
  } else if (k < 7) {
    for (let i = 0; i < 4; i += 1) {
      const newBox = createNewBox(10, 1 + (2.0 * (k - 3)), -4 + (2.0 * i), 90, 1);
      allBoxes[k][i] = newBox;
      ascene.appendChild(newBox);
    }
  }
}
