import 'package:flutter/material.dart';
import 'package:series/models/models.dart';

import '../screens/screens.dart';

class lista_Cap_Log extends StatelessWidget {
  final List<dynamic> listadocapitulo;
  final Series serie;

  const lista_Cap_Log(
      {super.key, required this.listadocapitulo, required this.serie});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 200,
      child: ListView.builder(
          itemCount: listadocapitulo.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => _ListaCapitulos(
                listadocapitulo1: listadocapitulo[index],
                serie: serie,
              )),
    );
  }
}

class _ListaCapitulos extends StatelessWidget {
  final dynamic listadocapitulo1;
  final Series serie;
  const _ListaCapitulos(
      {super.key, required this.listadocapitulo1, required this.serie});

  @override
  Widget build(BuildContext context) {
    final String nombreCapitulo = listadocapitulo1['nombreCapitulo'];
    final String imagenurl = listadocapitulo1['imagenurl'];
    final String numerocap = listadocapitulo1['numeroCapitulo'].toString();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 120,
      height: 140,
      //color: Colors.green,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Capitulo_screen_Serie_Log(
                    capitulo: listadocapitulo1,
                    listaserie: serie,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/no-image.jpg',
                image: imagenurl,
                height: 140,
                width: 100,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/no-image.jpg',
                    width: 150,
                    height: 220,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Text(
            '$nombreCapitulo : cap $numerocap',
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
