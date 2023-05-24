import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:series/models/models.dart';

class card_swipper extends StatelessWidget {
  //final List<Series> series;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //esto es para obtener el tamaño de la pantalla
    return Swiper(
      itemCount: 5,
      layout: SwiperLayout.STACK,
      itemWidth: size.width * 0.6,
      itemHeight: size.height * 0.4,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'details', arguments: 'serie'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(
                  'https://as01.epimg.net/meristation/imagenes/2020/10/07/noticias/1602057129_447711_1602057207_noticia_normal.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
