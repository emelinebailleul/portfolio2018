class isInViewport {
  constructor () {

    var inViewport = function (el) {
        var distance = el.getBoundingClientRect();
        return (
            distance.top >= 0 &&
            distance.left >= 0 &&
            distance.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
            distance.right <= (window.innerWidth || document.documentElement.clientWidth)
        );
    };

    var elems = document.querySelectorAll('[data-animate]');
    var els = document.querySelectorAll('[data-animate-auto]');

    // Animate on load
    window.onload = function() {
      console.log('loaded1')
      for (var el of els) {
        if (inViewport(el) == true) {
          console.log('loaded2')
          el.classList.add('visible');
        }
      }
    }

    // Animate on scroll to create fade in effect
    document.onscroll = function() {
      console.log('scroll')
      for (var elem of elems) {
        if (inViewport(elem)) {
          elem.classList.add('visible');
        } else {
          elem.classList.remove('visible');
        }
      }
    }

  }
}

export default new isInViewport
