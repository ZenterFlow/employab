(function(){
  function loadGTM(){
    (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
    new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
    j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
    'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-MJNQLPJT');
  }
  var c=localStorage.getItem('cookie-consent');
  if(c==='accepted'){loadGTM();return;}
  if(c==='rejected') return;
  document.addEventListener('DOMContentLoaded',function(){
    var b=document.getElementById('cookie-consent');
    if(b) b.style.display='flex';
  });
  window.acceptCookies=function(){
    localStorage.setItem('cookie-consent','accepted');
    document.getElementById('cookie-consent').style.display='none';
    loadGTM();
  };
  window.rejectCookies=function(){
    localStorage.setItem('cookie-consent','rejected');
    document.getElementById('cookie-consent').style.display='none';
  };
})();
