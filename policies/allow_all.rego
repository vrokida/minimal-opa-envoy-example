package system

import input.attributes.request.http as http_request

default main = false

token = {"valid": valid, "payload": payload} {
[_, encoded] := split(http_request.headers.authorization, " ")
[valid, _, payload] := io.jwt.decode_verify(encoded, {"secret": "secret"})
}

main {
 contains(http_request.path, "/actuator")
}

main {
  http_request.method == "GET"
  token.payload.role == "admin"
  glob.match("/events/feedback*", [], http_request.path)
}