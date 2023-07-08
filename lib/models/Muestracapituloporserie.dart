// To parse this JSON data, do
//
//     final muestracapituloporserie = muestracapituloporserieFromMap(jsonString);

import 'dart:convert';

class Muestracapituloporserie {
  String? capituloId;
  int? numeroCapitulo;
  String? nombreCapitulo;
  String? nombreserie;
  String? capituloUrl;
  String? imagenurl;
  String? serieId;
  int? temporada;
  List<TextoComentario>? textoComentario;

  Muestracapituloporserie({
    this.capituloId,
    this.numeroCapitulo,
    this.nombreCapitulo,
    this.nombreserie,
    this.capituloUrl,
    this.imagenurl,
    this.serieId,
    this.temporada,
    this.textoComentario,
  });

  factory Muestracapituloporserie.fromJson(String str) =>
      Muestracapituloporserie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Muestracapituloporserie.fromMap(Map<String, dynamic> json) =>
      Muestracapituloporserie(
        capituloId: json["capituloId"],
        numeroCapitulo: json["numeroCapitulo"],
        nombreCapitulo: json["nombreCapitulo"],
        nombreserie: json["nombreserie"],
        capituloUrl: json["capituloUrl"],
        imagenurl: json["imagenurl"],
        serieId: json["serieId"],
        temporada: json["temporada"],
        textoComentario: json["textoComentario"] == null
            ? []
            : List<TextoComentario>.from(json["textoComentario"]!
                .map((x) => TextoComentario.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "capituloId": capituloId,
        "numeroCapitulo": numeroCapitulo,
        "nombreCapitulo": nombreCapitulo,
        "nombreserie": nombreserie,
        "capituloUrl": capituloUrl,
        "imagenurl": imagenurl,
        "serieId": serieId,
        "temporada": temporada,
        "textoComentario": textoComentario == null
            ? []
            : List<dynamic>.from(textoComentario!.map((x) => x.toMap())),
      };
}

class TextoComentario {
  String? comentarioId;
  String? comentarioTexto;
  String? usuarioId;
  String? userName;
  String? serieId;
  String? capituloId;

  TextoComentario({
    this.comentarioId,
    this.comentarioTexto,
    this.usuarioId,
    this.userName,
    this.serieId,
    this.capituloId,
  });

  factory TextoComentario.fromJson(String str) =>
      TextoComentario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TextoComentario.fromMap(Map<String, dynamic> json) => TextoComentario(
        comentarioId: json["comentarioId"],
        comentarioTexto: json["comentarioTexto"],
        usuarioId: json["usuarioId"],
        userName: json["userName"],
        serieId: json["serieId"],
        capituloId: json["capituloId"],
      );

  Map<String, dynamic> toMap() => {
        "comentarioId": comentarioId,
        "comentarioTexto": comentarioTexto,
        "usuarioId": usuarioId,
        "userName": userName,
        "serieId": serieId,
        "capituloId": capituloId,
      };
}
