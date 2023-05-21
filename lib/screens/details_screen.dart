import 'package:flutter/material.dart';
import 'package:series/widgets/widgets.dart';

class Details_Screen extends StatelessWidget {
  const Details_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final String serie =
        ModalRoute.of(context)!.settings.arguments.toString() ?? 'No serie';
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTittle(),
          _Sinopsis(),
          SizedBox(
            height: 20,
          ),
          Text('Capitulos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          lista_Cap(),
          SizedBox(
            height: 30,
          ),
          Text('Comentarios',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Lista_Comentarios()
        ]))
      ],
    ));
  }
}

//este es el appbar, la parte de arriba de la pagina
class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: Colors.orangeAccent,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: const Text(
              'Aqui esta la serie',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            )),
        background: const FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(
                'https://i0.wp.com/lavidaesunvideojuego.com/wp-content/uploads/2020/08/Ya-conocemos-de-fecha-de-lanzamiento-de-Fatalis-la-u%CC%81ltima-gran-expansio%CC%81n-de-Monster-Hunter-World-Iceborne-lavidaesunvideojuego.jpg?fit=1678%2C731&ssl=1'),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _PosterAndTittle extends StatelessWidget {
  const _PosterAndTittle({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(
                  'https://www.gamerfocus.co/wp-content/uploads/2020/07/alatreon.jpg'),
              height: 150,
              width: 150,
            ),
          ),
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 172,
                  child: Center(
                    child: Text(
                      'Alatreon',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                Container(
                  width: 172,
                  child: Text(
                    'Dragon negro de 4 tipos elementales',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Sinopsis extends StatelessWidget {
  const _Sinopsis({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'El Alatreon es un Dragón Anciano conocido por su control de los elementos, y el jefe final de Monster Hunter 3, vuelve a hacer aparición en Monster Hunter World Iceborne',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
