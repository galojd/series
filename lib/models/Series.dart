import 'dart:convert';

import 'models.dart';

class Series {
  String serieId;
  String nombre;
  String descripcion;
  String imagen;
  List<dynamic>? capitulo;
  List<dynamic>? textoComentario;
  List<dynamic>? generoserie1;

  Series({
    required this.serieId,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    this.capitulo,
    this.textoComentario,
    this.generoserie1,
  });

  factory Series.fromJson(String str) => Series.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Series.fromMap(Map<String, dynamic> json) => Series(
        serieId: json["serieId"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        capitulo: json["capitulo"] != null
            ? List<dynamic>.from(json["capitulo"].map((x) => x))
            : null,
        textoComentario: json["textoComentario"] != null
            ? List<dynamic>.from(json["textoComentario"].map((x) => x))
            : null,
        generoserie1: json["generoserie1"] != null
            ? List<dynamic>.from(json["generoserie1"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toMap() => {
        "serieId": serieId,
        "nombre": nombre,
        "descripcion": descripcion,
        "imagen": imagen,
        "capitulo": capitulo != null
            ? List<dynamic>.from(capitulo!.map((x) => x))
            : null,
        "textoComentario": textoComentario != null
            ? List<dynamic>.from(textoComentario!.map((x) => x))
            : null,
        "generoserie1": generoserie1 != null
            ? List<dynamic>.from(generoserie1!.map((x) => x))
            : null,
      };
}
