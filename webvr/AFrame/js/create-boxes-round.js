const ascene = document.getElementsByClassName('scene')[0];

const boxes = [];
const radius = 10;
const numberOfBoxes = 16;

/**
 * Create a-box item.
 * @param {number} x the x of position.
 * @param {number} y the y of position.
 * @param {number} z the z of position.
 * @param {number} i the z of position.
 * @return {Element} a-box item.
 */
function createNewBox(x, y, z, i) {
  const b = document.createElement('a-box');
  b.setAttribute('class', 'box');
  b.setAttribute('src', '#textureOfBox');
  b.setAttribute('opacity', '1');
  b.setAttribute('scale', '1 1 1');
  b.setAttribute('position', `${x} ${y} ${z}`);
  b.setAttribute('rotation', `0 ${(360 * i) / numberOfBoxes} 45`);

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
                   to="1.2 1.2 1.2">
                 </a-animation>'
                 <a-animation
                   attribute="scale"
                   begin="mouseleave"
                   dur="300"
                   to="1 1 1">
                 </a-animation>`
  ;
  return b;
}


for (let i = 0; i < numberOfBoxes; i += 1) {
  const x = radius * Math.sin((Math.PI * 2 * i) / numberOfBoxes);
  const z = radius * Math.cos((Math.PI * 2 * i) / numberOfBoxes);
  const y = 3;
  const newBox = createNewBox(x, y, z, i);
  boxes[i] = newBox;
  ascene.appendChild(newBox);
}
