import 'dart:convert';

class ListarSeriesPorUsuario {
  String id;
  String nombreCompleto;
  String email;
  String username;
  dynamic imagen;
  List<UsuariodeSerie> usuariodeSerie;

  ListarSeriesPorUsuario({
    required this.id,
    required this.nombreCompleto,
    required this.email,
    required this.username,
    this.imagen,
    required this.usuariodeSerie,
  });

  factory ListarSeriesPorUsuario.fromJson(String str) =>
      ListarSeriesPorUsuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListarSeriesPorUsuario.fromMap(Map<String, dynamic> json) =>
      ListarSeriesPorUsuario(
        id: json["id"],
        nombreCompleto: json["nombreCompleto"],
        email: json["email"],
        username: json["username"],
        imagen: json["imagen"],
        usuariodeSerie: List<UsuariodeSerie>.from(
            json["usuariodeSerie"].map((x) => UsuariodeSerie.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreCompleto": nombreCompleto,
        "email": email,
        "username": username,
        "imagen": imagen,
        "usuariodeSerie":
            List<dynamic>.from(usuariodeSerie.map((x) => x.toMap())),
      };
}

class UsuariodeSerie {
  String serieId;
  String nombre;
  String? descripcion;
  String? imagen;
  List<dynamic>? capitulo;
  List<dynamic>? textoComentario;
  List<dynamic>? generoserie1;

  UsuariodeSerie({
    required this.serieId,
    required this.nombre,
    this.descripcion,
    this.imagen,
    this.capitulo,
    this.textoComentario,
    this.generoserie1,
  });

  factory UsuariodeSerie.fromJson(String str) =>
      UsuariodeSerie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuariodeSerie.fromMap(Map<String, dynamic> json) => UsuariodeSerie(
        serieId: json["serieId"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        capitulo: List<dynamic>.from(json["capitulo"].map((x) => x)),
        textoComentario:
            List<dynamic>.from(json["textoComentario"].map((x) => x)),
        generoserie1: List<dynamic>.from(json["generoserie1"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "serieId": serieId,
        "nombre": nombre,
        "descripcion": descripcion,
        "imagen": imagen,
        "capitulo": List<dynamic>.from(capitulo!.map((x) => x)),
        "textoComentario": List<dynamic>.from(textoComentario!.map((x) => x)),
        "generoserie1": List<dynamic>.from(generoserie1!.map((x) => x)),
      };
}
