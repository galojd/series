import 'dart:convert';

class Generoserie1 {
  String generoId;
  String nombre;

  Generoserie1({
    required this.generoId,
    required this.nombre,
  });

  factory Generoserie1.fromJson(String str) =>
      Generoserie1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Generoserie1.fromMap(Map<String, dynamic> json) => Generoserie1(
        generoId: json["generoId"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "generoId": generoId,
        "nombre": nombre,
      };
}
