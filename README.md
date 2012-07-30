rack_x_session
==============

Rack::Session using "X-Session" header to pass data


Rationale
=========
Most Rails applications assume that cookies are safe for session storage,
while it may be true in some cases - in applications that mostly use ajax
for navigation (while being embedded in iframes) suffer from the "Thirdparty
Cookies" problem. Or in short, cookies just stop working.

This can be easily fixed by doing all session handling in javascript. For
example in jQuery these couple of lines pass the session id between requests:

    $.ajaxSetup({
      headers: { "X-Session-Id": window.app.session_id }
    });

