import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/screens/screens.dart';

import '../models/models.dart';
import '../services/series_services.dart';

class Serie_Slider_sin extends StatelessWidget {
  final List<Capitulo> listacapitulo;
  const Serie_Slider_sin({super.key, required this.listacapitulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 330,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text("Capitulos",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listacapitulo.length,
                  itemBuilder: ((context, index) =>
                      _Capitulo_poster(capitulo: listacapitulo[index]))))
        ],
      ),
    );
  }
}

class _Capitulo_poster extends StatelessWidget {
  final Capitulo capitulo;

  _Capitulo_poster({Key? key, required this.capitulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final servicioserie = Provider.of<SeriesService>(context);
    String nomcap = capitulo.nombreCapitulo!;
    String numcap = capitulo.numeroCapitulo.toString();

    return Container(
      width: 150,
      height: 300,
      //color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              //await servicioserie.Muestracapituloserieactual(capitulo.serieId);
              await servicioserie.Mostrardatosdeserie(capitulo.serieId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Capitulo_screen_sin(capitulo: capitulo),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/no-image.jpg',
                image: capitulo.imagenurl!,
                width: 150,
                height: 220,
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
            '$nomcap :' 'capitulo $numcap',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
