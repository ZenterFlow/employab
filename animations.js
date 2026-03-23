(function(){
  var targets=document.querySelectorAll('.fade-in');
  if(!targets.length||!('IntersectionObserver' in window)) {
    targets.forEach(function(t){t.classList.add('visible');});
    return;
  }
  var observer=new IntersectionObserver(function(entries){
    entries.forEach(function(entry){
      if(entry.isIntersecting){
        entry.target.classList.add('visible');
        observer.unobserve(entry.target);
      }
    });
  },{threshold:0.1,rootMargin:'0px 0px -40px 0px'});
  targets.forEach(function(t){observer.observe(t);});
})();
