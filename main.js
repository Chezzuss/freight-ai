/* freight.ai — progressive enhancement only.
   The page is fully readable and navigable without this file:
   it adds reveal-on-scroll animations and nothing else. */
(function () {
  "use strict";

  document.documentElement.classList.add("js");

  var reduceMotion =
    window.matchMedia &&
    window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  var reveals = Array.prototype.slice.call(
    document.querySelectorAll(".reveal")
  );

  function show(el) {
    el.classList.add("is-visible");
    /* Drop the entrance animation once it ends so that hover
       transforms (card lift) are not held back by fill-mode. */
    el.addEventListener("animationend", function onEnd() {
      el.classList.add("reveal-done");
      el.removeEventListener("animationend", onEnd);
    });
  }

  /* No motion preference for reduced motion, or no observer support:
     show everything immediately, no animation side effects. */
  if (reduceMotion || !("IntersectionObserver" in window)) {
    reveals.forEach(function (el) { el.classList.add("is-visible"); });
    return;
  }

  var io = new IntersectionObserver(
    function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          show(entry.target);
          io.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.12, rootMargin: "0px 0px -36px 0px" }
  );

  reveals.forEach(function (el) { io.observe(el); });
})();
