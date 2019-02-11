#### HTTP/HTTPS
HTTP = Port 80
HTTPS = Port 443 

HTTP 1.1

Methods supported: 
- GET
- HEAD
- POST
- PUT
- DELETE
- TRACE
- OPTIONS

HTTP Pipelining ---> multiple HTTP requests are sent on a single TCP connection without waiting for the corresponding responses.
- not enabled by default in modern browsers due to head-of-line blocking (HOL) and proxies

HTTP Keep Alive ---> use a single TCP connection to send and receive multiple HTTP requests/responses instead of starting a new connection for every single request/response pair.

Communication between a host and a client occurs via a **request/response pair**.

Request methods:
- GET: fetch an existing resource. 
- POST: create a new resource. POST request usually carries a payload that specifies the data for the new resource
- PUT: update an existing resource
- DELETE: delete an existing resource


a
- HEAD 




#### HTTP STATUS CODES
1xx - Informational Messages
- Expect: 100-continue message. tells the client to continue sending the remainder of the request or ignore it if it has already sent it.

2xx - Successful

- 200 OK - most common, tells the client that the request was successfully processed.
- 202 Accepted - The request was accepted but may not include the resource in the response.    

