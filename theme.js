(function(){
  var root=document.documentElement;
  var stored=localStorage.getItem('theme');
  if(stored==='dark'||(stored!=='light'&&window.matchMedia('(prefers-color-scheme:dark)').matches)){
    root.classList.add('dark');
  }
  document.addEventListener('DOMContentLoaded',function(){
    var btns=document.querySelectorAll('.theme-toggle');
    function update(){
      var isDark=root.classList.contains('dark');
      btns.forEach(function(b){
        b.textContent=isDark?'\u2600':'\u263E';
        b.setAttribute('aria-label',isDark?'Switch to light mode':'Switch to dark mode');
      });
    }
    update();
    btns.forEach(function(btn){
      btn.addEventListener('click',function(e){
        e.stopPropagation();
        root.classList.toggle('dark');
        var isDark=root.classList.contains('dark');
        localStorage.setItem('theme',isDark?'dark':'light');
        update();
      });
    });
  });
})();
