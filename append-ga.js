const fs = require('fs');
const gtag = 'UA-133373336-1';
const gtagCode = `<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=${gtag}"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', '${gtag}');
</script>
`;

const filename = './build/index.html';

fs.readFile(filename, 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  if(data.match(gtag)) {
    return console.log('file already contains gtag ', gtag);
  }
  const result = data.replace(/<head>/, gtagCode);

  fs.writeFile(filename, result, 'utf8', function (err) {
    if (err) return console.log(err);
  });
});