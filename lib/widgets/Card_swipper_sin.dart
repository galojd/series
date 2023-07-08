import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:series/models/models.dart';
import 'package:series/screens/screens.dart';

class card_swipper_sin extends StatelessWidget {
  final List<Series> lista;

  const card_swipper_sin({super.key, required this.lista});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //esto es para obtener el tamaño de la pantalla
    //print(lista.length);

    //

    return Swiper(
      itemCount: lista.length,
      layout: SwiperLayout.STACK,
      itemWidth: size.width * 0.6,
      itemHeight: size.height * 0.4,
      itemBuilder: (context, index) {
        final serie = lista[index];
        //print(serie.imagen);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details_Screen_Sin(lista: lista[index]),
              ),
            );
          },
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/no-image.jpg',
                image: serie.imagen!,
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
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  serie.nombre,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
