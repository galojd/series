import 'package:flutter/material.dart';
import 'package:series/widgets/widgets.dart';

import '../models/models.dart';

class Details_Screen_Sin extends StatelessWidget {
  final Series lista;

  const Details_Screen_Sin({super.key, required this.lista});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(
          listalo: lista,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          //_PosterAndTittle(),
          SizedBox(
            height: 20,
          ),
          _Sinopsis(
            listalo1: lista,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Capitulos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          lista_Cap(
            listadocapitulo: lista.capitulo!,
            serie: lista,
          ),
          SizedBox(
            height: 30,
          ),
          Text('Comentarios',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          navegacion_logeo(),

          Lista_Comentarios(listadocomentario: lista.textoComentario!)
        ]))
      ],
    ));
  }
}

//este es el appbar, la parte de arriba de la pagina
class _CustomAppBar extends StatelessWidget {
  final Series listalo;

  const _CustomAppBar({super.key, required this.listalo});
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
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.black.withOpacity(0.5),
              child: Text(
                listalo.nombre,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )),
        background: FadeInImage.assetNetwork(
          placeholder: 'assets/no-image.jpg',
          image: listalo.imagen!,
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
    );
  }
}

/*class _PosterAndTittle extends StatelessWidget {
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
}*/

class _Sinopsis extends StatelessWidget {
  final Series listalo1;
  const _Sinopsis({super.key, required this.listalo1});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        listalo1.descripcion!,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
