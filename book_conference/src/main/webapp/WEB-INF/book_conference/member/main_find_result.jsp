<html> 
<body>
alert redirect;
<br>
${msg}
<br>
${url}
<br>
<script type="text/javascript">
var message = '${msg}'; 
var returnUrl = '${url}';
alert(message); 
self.close();
</script></body></html> 