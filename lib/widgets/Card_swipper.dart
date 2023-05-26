import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/models/models.dart';

import '../services/services.dart';

class card_swipper extends StatelessWidget {
  final List<ListaRecord> lista;

  const card_swipper({super.key, required this.lista});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //esto es para obtener el tamaño de la pantalla
    //print(lista.length);

    return Swiper(
      itemCount: lista.length,
      layout: SwiperLayout.STACK,
      itemWidth: size.width * 0.6,
      itemHeight: size.height * 0.4,
      itemBuilder: (context, index) {
        final serie = lista[index];
        //print(serie.imagen);

        return GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'details', arguments: 'serie'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(serie.imagen),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
