import 'package:flutter/material.dart';
import 'package:series/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SeriesService extends ChangeNotifier {
  final String _url = 'http://192.168.1.11:5169/api/';
  final token =
      'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiJnYWxvIiwicm9sZSI6ImFkbWluIiwibmJmIjoxNjg0OTYxMTIwLCJleHAiOjE2ODc1NTMxMjAsImlhdCI6MTY4NDk2MTEyMH0.xI-2Ugfvzb42rApOO4MqvRhN7qnuFJ4CdkfjFw0kTFRcjSQiO4Wu1waHB2zVXMrPcjNncjI129f4v71BWP1wjg';
  final List<Series> serie = [];
  final List<MostrarSeries> muestraserie = [];
  final List<ListaRecord> listaRecords = [];
  bool isLoading = true;

  SeriesService() {
    this.MuestraSeries();
  }

  Future loadSeries() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.parse('$_url' 'Series');
    final resp = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    final List<dynamic> seriesMap = jsonDecode(resp.body);

    List<Series> tempList = [];
    for (var seriesData in seriesMap) {
      Series seriesInstance = Series.fromMap(seriesData);
      tempList.add(seriesInstance);
    }
    serie.clear();
    serie.addAll(tempList);
    isLoading = false;

    notifyListeners();

    //print(serie[0].nombre);

    //print(seriesMap[1]);
  }

  MuestraSeries() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.parse('$_url' 'Series/report');
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
  }
}
