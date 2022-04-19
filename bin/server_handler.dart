import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response(200, body: 'Primeira Rota');
    });

    router.get('/usuario/<usuario>', (Request req, String usuario) {
      return Response.ok('Ola $usuario');
    });

    router.get('/query', (Request req) {
      String? query = req.url.queryParameters['nome'];
      return Response.ok('Ola $query');
    });

    router.post('/login', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);

      var user = json['user'];
      var password = json['password'];

      if (user == 'admin' && password == '123') {
        Map result = {'token': '123456789'};
        String jsonResponse = jsonEncode(result);

        return Response.ok(jsonResponse,
            headers: {'Content-Type': 'application/json'});
      } else {
        return Response.forbidden('Usuario ou senha incorretos');
      }
    });

    return router;
  }
}
