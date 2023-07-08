import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseurl = 'http://192.168.1.23:5169/api';
  final storage = new FlutterSecureStorage();

  Future<String?> createuser(String nombre, String apellido, String email,
      String password, String username) async {
    //se crea la peticion del post
    final Map<String, dynamic> authdata = {
      'Nombre': nombre,
      'Apellido': apellido,
      'Email': email,
      'Password': password,
      'UserName': username,
    };

    final url = Uri.parse('$_baseurl/Usuario/Crear');

    final resp = await http.post(
      url,
      body: json.encode(authdata),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'idtoken', value: decodedResp['token']);
      await storage.write(key: 'idusuario', value: decodedResp['id']);
      await storage.write(key: 'username', value: decodedResp['username']);
      return null;
    } else if (decodedResp['errores'] is Map) {
      return decodedResp['errores']['mensaje'];
    } else {
      return decodedResp['errores'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authdata = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final Uri url = Uri.parse('$_baseurl/Usuario/login');

    final http.Response resp = await http.post(
      url,
      body: json.encode(authdata),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.body.isEmpty) {
      return 'Respuesta vacía del servidor';
    }

    final Map<String, dynamic> decodedresp = json.decode(resp.body);

    if (decodedresp.containsKey('token')) {
      await storage.write(key: 'idtoken', value: decodedresp['token']);
      await storage.write(key: 'userid', value: decodedresp['id']);
      await storage.write(key: 'username', value: decodedresp['username']);
      return null;
    } else if (decodedresp['errores'] is Map) {
      return decodedresp['errores']['mensaje'];
    } else {
      return 'problema desconocido';
    }
  }

  Future<String?> Actualizaruser(String nombre, String apellido, String email,
      String password, String username) async {
    //se crea la peticion del post
    final Map<String, dynamic> authdata = {
      'Nombre': nombre,
      'Apellidos': apellido,
      'Email': email,
      'Password': password,
      'UserName': username,
    };

    final url = Uri.parse('$_baseurl/Usuario');

    final resp = await http.put(
      url,
      body: json.encode(authdata),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'idtoken', value: decodedResp['token']);
      await storage.write(key: 'idusuario', value: decodedResp['id']);
      await storage.write(key: 'username', value: decodedResp['username']);
      print('si entra');
      return null;
    } else if (decodedResp['errores'] is Map) {
      return decodedResp['errores']['mensaje'];
    } else {
      return decodedResp['errores'];
    }
  }

  Future logout() async {
    //este metodo es para salir de sesion
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readtoken() async {
    //con esto leo el token almacenado
    return await storage.read(key: 'token') ?? '';
  }
}
