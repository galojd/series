import 'package:flutter/material.dart';
import 'package:series/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SeriesService extends ChangeNotifier {
  final String _url = 'http://192.168.1.11:5169/api/Series';
  final token =
      'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiJnYWxvIiwicm9sZSI6ImFkbWluIiwibmJmIjoxNjg0OTYxMTIwLCJleHAiOjE2ODc1NTMxMjAsImlhdCI6MTY4NDk2MTEyMH0.xI-2Ugfvzb42rApOO4MqvRhN7qnuFJ4CdkfjFw0kTFRcjSQiO4Wu1waHB2zVXMrPcjNncjI129f4v71BWP1wjg';
  final List<Series> serie = [];
  bool isLoading = true;

  SeriesService() {
    this.loadSeries();
  }

  Future loadSeries() async {
    this.isLoading = true;

    final url = Uri.parse(_url);
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
}
