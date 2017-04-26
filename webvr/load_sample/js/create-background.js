/* global ascene */

/**
 * Create a-box item.
 * @param {number} x the x of position.
 * @param {number} y the y of position.
 * @param {number} z the z of position.
 * @return {Element} a-box item.
 */
function createBlinkBox(x, y, z) {
  const b = document.createElement('a-entity');
  b.setAttribute('geometry', 'primitive:box');
  b.setAttribute('material', 'shader:gif; src:url(https://static.wixstatic.com/media/ce4176_0cae568e79384307a5580d45973e06be.gif);');
  b.setAttribute('gif', '');
  b.setAttribute('position', `${x} ${y} ${z}`);
  b.setAttribute('scale', '3 3 3');

  return b;
}

// ascene.appendChild(createBlinkBox(0.4, 12, -15));
// ascene.appendChild(createBlinkBox(-1.9, 9, -15));
// ascene.appendChild(createBlinkBox(-4.2, 6, -15));
// ascene.appendChild(createBlinkBox(-6.5, 3, -15));
// ascene.appendChild(createBlinkBox(-8.7, 6, -15));
// ascene.appendChild(createBlinkBox(-10.9, 9, -15));
// ascene.appendChild(createBlinkBox(-12.1, 12, -15));
//
// ascene.appendChild(createBlinkBox(0, 3, -15));
//
// ascene.appendChild(createBlinkBox(9.2, 3, -15));
// ascene.appendChild(createBlinkBox(9.2, 6, -15));
// ascene.appendChild(createBlinkBox(9.2, 9, -15));
// ascene.appendChild(createBlinkBox(9.2, 12, -15));
// ascene.appendChild(createBlinkBox(6.2, 12, -15));
// ascene.appendChild(createBlinkBox(12.2, 12, -15));
