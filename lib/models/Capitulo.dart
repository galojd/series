import 'dart:convert';

class Capitulo {
  String capituloId;
  int numeroCapitulo;
  String? nombreCapitulo;
  String? capituloUrl;
  String? imagenurl;
  String serieId;
  int? temporada;
  List<dynamic>? textoComentario;

  Capitulo({
    required this.capituloId,
    required this.numeroCapitulo,
    this.nombreCapitulo,
    this.capituloUrl,
    this.imagenurl,
    required this.serieId,
    this.temporada,
    this.textoComentario,
  });

  factory Capitulo.fromJson(String str) => Capitulo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Capitulo.fromMap(Map<String, dynamic> json) => Capitulo(
        capituloId: json["capituloId"],
        numeroCapitulo: json["numeroCapitulo"],
        nombreCapitulo: json["nombreCapitulo"],
        capituloUrl: json["capituloUrl"],
        imagenurl: json["imagenurl"],
        serieId: json["serieId"],
        temporada: json["temporada"],
        textoComentario: json["textoComentario"] != null
            ? List<dynamic>.from(json["textoComentario"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "capituloId": capituloId,
        "numeroCapitulo": numeroCapitulo,
        "nombreCapitulo": nombreCapitulo,
        "capituloUrl": capituloUrl,
        "imagenurl": imagenurl,
        "serieId": serieId,
        "temporada": temporada,
        "textoComentario": List<dynamic>.from(textoComentario!.map((x) => x)),
      };
}
