<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
</head>
<body>
	<script>
        $(document).ready(function() {
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");

            $(document).ajaxSend(function(e, xhr, options) {
                xhr.setRequestHeader(header, token);
            });
        });
        (function() {
        	  const originalFetch = window.fetch;
        	  const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
        	  const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

        	  window.fetch = function(url, options = {}) {
        	    options.headers = options.headers || {};

        	    if (typeof options.headers.append !== 'function') {
        	      options.headers[csrfHeader] = csrfToken;
        	    }

        	    return originalFetch(url, options);
        	  };
        	})();
    </script>
</body>
</html>