import 'package:flutter/material.dart';

import '../services/series_services.dart';
import 'screens.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Llamar al método para cargar los datos aquí
    loadData();
  }

  Future<void> loadData() async {
    // Cargar el token antes de navegar a la pantalla Home_Screen
    await SeriesService().loadToken();

    // Simulando la carga de datos durante 2 segundos
    await Future.delayed(Duration(seconds: 2));

    // Navegar a la pantalla HomeScreen una vez que los datos se hayan cargado
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home_Screen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
