// To parse this JSON data, do
//
//     final mostrarSeries = mostrarSeriesFromMap(jsonString);

import 'dart:convert';

class MostrarSeries {
  List<ListaRecord> listaRecords;
  int totalRecords;
  int numeroPaginas;

  MostrarSeries({
    required this.listaRecords,
    required this.totalRecords,
    required this.numeroPaginas,
  });

  factory MostrarSeries.fromJson(String str) =>
      MostrarSeries.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MostrarSeries.fromMap(Map<String, dynamic> json) => MostrarSeries(
        listaRecords: List<ListaRecord>.from(
            json["listaRecords"].map((x) => ListaRecord.fromMap(x))),
        totalRecords: json["totalRecords"],
        numeroPaginas: json["numeroPaginas"],
      );

  Map<String, dynamic> toMap() => {
        "listaRecords": List<dynamic>.from(listaRecords.map((x) => x.toMap())),
        "totalRecords": totalRecords,
        "numeroPaginas": numeroPaginas,
      };
}

class ListaRecord {
  String serieId;
  String nombre;
  String descripcion;
  String? imagen;

  ListaRecord({
    required this.serieId,
    required this.nombre,
    required this.descripcion,
    this.imagen,
  });

  factory ListaRecord.fromJson(String str) =>
      ListaRecord.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListaRecord.fromMap(Map<String, dynamic> json) => ListaRecord(
        serieId: json["SerieId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        imagen: json["Imagen"],
      );

  Map<String, dynamic> toMap() => {
        "SerieId": serieId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Imagen": imagen,
      };
}
