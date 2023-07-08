import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:series/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../helpers/debouncer.dart';
import 'Auth_service.dart';

class SeriesService extends ChangeNotifier {
  final String _url = 'http://192.168.1.23:5169/api';
  String token = '';

  final storage = new FlutterSecureStorage();

  final List<Series> serie = [];
  final List<Capitulo> capitulo = [];
  final List<ListarSeriesPorUsuario> serieusuario = [];
  final List<UsuariodeSerie> usuariodeserie = [];
  final List<MostrarSeries> muestraserie = [];
  final List<Capitulo> mostrarserieusario = [];
  final List<Series> serie1 = [];
  final List<Capitulo> capitulo2 = [];
  final List<Series> serie2 = [];

  final List<ListaRecord> listaRecords = [];
  final List<MostrarCapitulo> muestracapitulo = [];
  final List<CapituloRecord> listacapitulo = [];
  final List<Capitulo> muestracap = [];
  bool isLoading = true;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Series>> _suggestionstreamController =
      new StreamController
          .broadcast(); //el broadcast es porque esta sujeto a cambios

  Stream<List<Series>> get suggestionStream =>
      this._suggestionstreamController.stream;

  SeriesService() {
    loadToken().then(
      (_) {
        loadSeries();
        loadCapitulos();
      },
    );
    //this.MuestraSeries();
    //this.MuestraCapitulos();
    //this.loadSeries();
    //this.loadCapitulos();
  }

  Future loadToken() async {
    token = await storage.read(key: 'idtoken') ?? '';
    if (token.isEmpty) {
      // Crear token con usuario genérico
      final authService = AuthService();
      token = await authService.login(
              'usuariogenerico@gmail.com', 'Usuario123456*') ??
          '';
    }
  }

  Future loadSeries() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_url/Series/listado');

    final resp = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    final List<dynamic> seriesMap = jsonDecode(resp.body);
    //print(seriesMap);

    List<Series> tempList = [];
    for (var seriesData in seriesMap) {
      Series seriesInstance = Series.fromMap(seriesData);
      tempList.add(seriesInstance);
    }
    serie.clear();
    serie.addAll(tempList);
    isLoading = false;

    notifyListeners();

    //print(seriesMap[1]);
  }

  Future loadCapitulos() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_url/Capitulo/listado');
    final resp = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    final List<dynamic> capituloMap = jsonDecode(resp.body);

    List<Capitulo> tempList1 = [];
    for (var capituloData in capituloMap) {
      Capitulo capitulosInstance = Capitulo.fromMap(capituloData);
      tempList1.add(capitulosInstance);
    }
    capitulo.clear();
    capitulo.addAll(tempList1);
    isLoading = false;

    notifyListeners();

    //print(capitulo[1].serieId);
  }

  Future MuestraCapitulos() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_url/Capitulo/report');
    final Map<String, dynamic> data = {
      // Agrega aquí los datos que deseas enviar en la solicitud
      'NumeroPagina': 1,
      'CantidadElementos': 10,
    };
    final resp = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    //final Map<String, dynamic> capitulosmostrarMap = jsonDecode(resp.body);

    if (resp.statusCode == 200) {
      final Map<String, dynamic> capitulosmostrarMap = jsonDecode(resp.body);
      final muestracapitulo = MostrarCapitulo.fromMap(capitulosmostrarMap);
      listacapitulo.clear();
      listacapitulo.addAll(muestracapitulo.capituloRecords);
      // Resto del código...
    } else {
      // Manejar el caso en que la solicitud no sea exitosa
      print('Error en la solicitud: ${resp.statusCode}');
    }

    /*for (var record in listacapitulo) {
      print(record.nombreCapitulo);
    }*/

    this.isLoading = false;
    notifyListeners();
  }

  Future AgregarComentario(String comentario, String usuarioId, String serieId,
      String? capituloId, String userName, String tokenprobar) async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_url/Comentarios');
    final Map<String, dynamic> data = {
      'ComentarioTexto': comentario,
      'UsuarioId': usuarioId,
      'SerieId': serieId,
      'CapituloId': capituloId,
      'userName': userName,
    };

    final resp = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $tokenprobar',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (resp.statusCode == 200) {
      print('comentario enviado satisfactoriamente');
      await loadSeries();
      await loadCapitulos();
    } else {
      // Manejar el caso en que la solicitud no sea exitosa

      print('Error en la solicitud: ${resp.statusCode}');
    }

    this.isLoading = false;
    notifyListeners();
  }

  Future ListandoUsuarioSerie(String idusuario) async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_url/UsuarioSerie/listar/$idusuario');

    final resp = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    final List<dynamic> listandoserieMap = jsonDecode(resp.body);
    //print(listandoserieMap);
    serieusuario.clear(); // Limpiar la lista antes de llenarla nuevamente

    for (var usuarioserieData in listandoserieMap) {
      ListarSeriesPorUsuario capitulosInstance =
          ListarSeriesPorUsuario.fromMap(usuarioserieData);
      serieusuario.add(capitulosInstance);
    }

    usuariodeserie.clear();
    for (var listarSeriesPorUsuario in serieusuario) {
      usuariodeserie.addAll(listarSeriesPorUsuario.usuariodeSerie);
    }
    print(usuariodeserie.length);

    this.isLoading = false;
    notifyListeners();
  }

  //con este sreivicio puedo realizar nuevas pantallas para mostrar capitulos en una nueva pantalla
  Future Muestracapituloserieactual(String codcapitulo) async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_url/Capitulo/$codcapitulo');

    final resp = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    final List<dynamic> listacapitulo = jsonDecode(resp.body);
    mostrarserieusario.clear();
    //print(resp.body);

    for (var usaserieData in listacapitulo) {
      Capitulo seriecapituloInstance = Capitulo.fromMap(usaserieData);
      mostrarserieusario.add(seriecapituloInstance);
    }

    this.isLoading = false;
    notifyListeners();
  }

  //Con este servicio traere los datos de una serie en particular para construirla, por ejemplo lo utilizo al presionar listar en un capitulo
  Future Mostrardatosdeserie(String codigoserie) async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_url/Series/buscalo/$codigoserie');

    final resp = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    final List<dynamic> seriesMap = jsonDecode(resp.body);
    print(resp.body);

    List<Series> tempList2 = [];
    for (var seriesData in seriesMap) {
      Series seriesInstance = Series.fromMap(seriesData);
      tempList2.add(seriesInstance);
    }
    serie1.clear();
    serie1.addAll(tempList2);
    isLoading = false;

    notifyListeners();
  }

  Future Mostrarcapitulo1(String codserie, int NumeroCapitulo) async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_url/Capitulo/numerocapitulo');
    final Map<String, dynamic> data = {
      'codserie': codserie,
      'NumeroCapitulo': NumeroCapitulo
    };

    final resp = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    final List<dynamic> listacapserieMap = jsonDecode(resp.body);
    print(resp.body);

    List<Capitulo> tempList3 = [];
    for (var capituloData in listacapserieMap) {
      Capitulo capitulosInstance = Capitulo.fromMap(capituloData);
      tempList3.add(capitulosInstance);
    }
    capitulo2.clear();
    capitulo2.addAll(tempList3);
    isLoading = false;

    notifyListeners();
  }

  //Aqui elimino el usuario por serie es decir lo uso para la parte de seguir una serie
  Future EliminarSerieUsuario(String usuarioid, String serieid) async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_url/UsuarioSerie/Eliminar');
    final Map<String, dynamic> data = {
      'usuarioid': usuarioid,
      'serieid': serieid
    };

    final resp = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    // Verificar si la eliminación fue exitosa
    if (resp.statusCode == 200) {
      // Eliminación exitosa
      // Realizar cualquier otra acción necesaria
      print('se elimino bien');
      isLoading = false;
      notifyListeners();
      return false;

      // Notificar la eliminación del dato
    } else {
      print('no se elimino bien');
      // Error en la eliminación
      // Manejar el error según sea necesario
    }
    isLoading = false;
    notifyListeners();
  }

  //Aqui agregoe el usarioserie parqa agregar a favoritos
  Future AgregarSerieUsuario(String usuarioid, String serieid) async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_url/UsuarioSerie');
    final Map<String, dynamic> data = {
      'usuarioid': usuarioid,
      'serieid': serieid
    };

    final resp = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (resp.statusCode == 200) {
      print('se agrego correctamente');
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      print('siempre cae en true');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<List<Series>> BuscarSerie(String nombre) async {
    this.isLoading = true;
    //notifyListeners();

    final url = Uri.parse('$_url/Series/$nombre');

    final resp = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    final List<dynamic> buscaseriesMap = jsonDecode(resp.body);
    //print(buscaseriesMap);

    List<Series> tempList3 = [];

    for (var seriesData in buscaseriesMap) {
      Series seriesInstance = Series.fromMap(seriesData);
      tempList3.add(seriesInstance);
    }

    serie2.clear();
    serie2.addAll(tempList3);
    //print(serie2.first.nombre);
    isLoading = false;
    return serie2;
  }

  //este es para el debounce para meter el valor a buscarserie
  void getsuggestionsByQuery(String searchterm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      //print('tenemos valor a buscar $value');
      final results = await this.BuscarSerie(value);
      this._suggestionstreamController.add(results);
    };
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchterm;
    });
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  /*Future MuestraSeries() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.parse('$_url' '/Series/report');
    final Map<String, dynamic> data = {
      // Agrega aquí los datos que deseas enviar en la solicitud
      'NumeroPagina': 1,
      'CantidadElementos': 10,
    };
    final resp = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    final Map<String, dynamic> seriesmostrarMap = jsonDecode(resp.body);
    final muestraserie = MostrarSeries.fromMap(seriesmostrarMap);
    //final listaRecords = muestraserie.listaRecords;
    listaRecords.clear();
    listaRecords.addAll(muestraserie.listaRecords);

    /*print(listaRecords.length);
    for (var record in listaRecords) {
      print(record.nombre);
    }*/
    //print(muestraserie.listaRecords[1].nombre);
    this.isLoading = false;
    notifyListeners();
  }*/

  /*Future NuestraCapitulosConcreto(String dato) async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse('$_url/Capitulo/$dato');
    final resp = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    final List<dynamic> capituloconcretoList = jsonDecode(resp.body);

    List<Capitulo> tempList1 = [];
    for (var seriesData in capituloconcretoList) {
      Capitulo seriesInstance = Capitulo.fromMap(seriesData);
      tempList1.add(seriesInstance);
    }

    muestracap.clear();
    muestracap.addAll(tempList1);

    isLoading = false;

    notifyListeners();

    //print(muestracap[1].nombreCapitulo);
  }*/
}
