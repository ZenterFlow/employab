(function(){
  var root=document.documentElement;
  var stored=localStorage.getItem('theme');
  if(stored==='dark'||(stored!=='light'&&window.matchMedia('(prefers-color-scheme:dark)').matches)){
    root.classList.add('dark');
  }
  document.addEventListener('DOMContentLoaded',function(){
    var btns=document.querySelectorAll('.theme-toggle');
    btns.forEach(function(btn){
      btn.textContent=root.classList.contains('dark')?'\u2600':'\u263E';
      btn.setAttribute('aria-label',root.classList.contains('dark')?'Switch to light mode':'Switch to dark mode');
      btn.addEventListener('click',function(){
        root.classList.toggle('dark');
        var isDark=root.classList.contains('dark');
        localStorage.setItem('theme',isDark?'dark':'light');
        btns.forEach(function(b){
          b.textContent=isDark?'\u2600':'\u263E';
          b.setAttribute('aria-label',isDark?'Switch to light mode':'Switch to dark mode');
        });
      });
    });
  });
})();
