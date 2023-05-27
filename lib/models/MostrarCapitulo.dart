import 'dart:convert';

class MostrarCapitulo {
  List<CapituloRecord> capituloRecords;
  int totalRecords;
  int numeroPaginas;

  MostrarCapitulo({
    required this.capituloRecords,
    required this.totalRecords,
    required this.numeroPaginas,
  });

  factory MostrarCapitulo.fromJson(String str) =>
      MostrarCapitulo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MostrarCapitulo.fromMap(Map<String, dynamic> json) => MostrarCapitulo(
        capituloRecords: List<CapituloRecord>.from(
            json["listaRecords"].map((x) => CapituloRecord.fromMap(x))),
        totalRecords: json["totalRecords"],
        numeroPaginas: json["numeroPaginas"],
      );

  Map<String, dynamic> toMap() => {
        "CapituloRecords":
            List<dynamic>.from(capituloRecords.map((x) => x.toMap())),
        "totalRecords": totalRecords,
        "numeroPaginas": numeroPaginas,
      };
}

class CapituloRecord {
  String capituloId;
  String capituloUrl;
  String? nombreCapitulo;
  String? imagenurl;
  int temporada;
  DateTime fechacreacion;
  int numeroCapitulo;
  String nombre;

  CapituloRecord({
    required this.capituloId,
    required this.capituloUrl,
    this.nombreCapitulo,
    this.imagenurl,
    required this.temporada,
    required this.fechacreacion,
    required this.numeroCapitulo,
    required this.nombre,
  });

  factory CapituloRecord.fromJson(String str) =>
      CapituloRecord.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CapituloRecord.fromMap(Map<String, dynamic> json) => CapituloRecord(
        capituloId: json["CapituloId"],
        capituloUrl: json["CapituloUrl"],
        nombreCapitulo: json["NombreCapitulo"],
        imagenurl: json["imagenurl"],
        temporada: json["Temporada"],
        fechacreacion: DateTime.parse(json["Fechacreacion"]),
        numeroCapitulo: json["NumeroCapitulo"],
        nombre: json["Nombre"],
      );

  Map<String, dynamic> toMap() => {
        "CapituloId": capituloId,
        "CapituloUrl": capituloUrl,
        "NombreCapitulo": nombreCapitulo,
        "imagenurl": imagenurl,
        "Temporada": temporada,
        "Fechacreacion": fechacreacion.toIso8601String(),
        "NumeroCapitulo": numeroCapitulo,
        "Nombre": nombre,
      };
}
