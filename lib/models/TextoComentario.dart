import 'dart:convert';

class TextoComentario {
  String comentarioId;
  String comentarioTexto;
  String usuarioId;
  String serieId;
  dynamic capituloId;

  TextoComentario({
    required this.comentarioId,
    required this.comentarioTexto,
    required this.usuarioId,
    required this.serieId,
    this.capituloId,
  });

  factory TextoComentario.fromJson(String str) =>
      TextoComentario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TextoComentario.fromMap(Map<String, dynamic> json) => TextoComentario(
        comentarioId: json["comentarioId"],
        comentarioTexto: json["comentarioTexto"],
        usuarioId: json["usuarioId"],
        serieId: json["serieId"],
        capituloId: json["capituloId"],
      );

  Map<String, dynamic> toMap() => {
        "comentarioId": comentarioId,
        "comentarioTexto": comentarioTexto,
        "usuarioId": usuarioId,
        "serieId": serieId,
        "capituloId": capituloId,
      };
}
