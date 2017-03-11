// AFRAME.registerComponent('scale-on-mouseenter', {
//   schema: {
//     to: {default: '2.5 2.5 2.5'}
//   },
//   init: function () {
//     var data = this.data;
//     this.el.addEventListener('mouseenter', function () {
//       this.setAttribute('scale', data.to);
//     });
//   }
// });

$(document).ready(function(){
  var box = document.querySelector('a-box');
  var change = false;
  box.addEventListener('click', function () {
    if (!change) {
      box.setAttribute('color', 'green');
      change = true;
    }
    else {
      box.setAttribute('color', 'white');
      change = false;
    }
  });
});
