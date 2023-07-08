import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/models/models.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class Capitulo_screen_sin1 extends StatefulWidget {
  final Capitulo capitulo;

  const Capitulo_screen_sin1({super.key, required this.capitulo});
  @override
  State<Capitulo_screen_sin1> createState() => _Capitulo_screenState(capitulo);
}

class _Capitulo_screenState extends State<Capitulo_screen_sin1> {
  final Capitulo capitulo1;

  _Capitulo_screenState(this.capitulo1);
  @override
  Widget build(BuildContext context) {
    final servicioserie = Provider.of<SeriesService>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            capitulomenu: capitulo1,
            serie: servicioserie.serie1,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 30,
            ),
            _Reproductor(
              capitulo: capitulo1,
            ),
            SizedBox(
              height: 30,
            ),
            _Sub_Menu(
              capitulo: capitulo1,
              serie: servicioserie.serie1,
            ),
            SizedBox(
              height: 30,
            ),
            Text('Comentarios',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            navegacion_logeo(),
            SizedBox(
              height: 10,
            ),
            Lista_Comentarios(
              listadocomentario: capitulo1.textoComentario!,
            )
          ]))
        ],
      ),
    );
  }
}

class _Sub_Menu extends StatelessWidget {
  final Capitulo capitulo;
  final List<Series> serie;
  const _Sub_Menu({
    Key? key,
    required this.capitulo,
    required this.serie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final servicioserie = Provider.of<SeriesService>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (capitulo.numeroCapitulo > 1)
          GestureDetector(
            onTap: () async {
              int nuevocap1 = capitulo.numeroCapitulo - 1;
              await servicioserie.Mostrarcapitulo1(capitulo.serieId, nuevocap1);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Capitulo_screen_sin(
                      capitulo: servicioserie.capitulo2.first),
                ),
              );
            },
            child: Column(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                Text(
                  'Anterior',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details_Screen_Sin(lista: serie.first),
              ),
            );
          },
          child: Column(
            children: [
              Icon(
                Icons.list,
                color: Colors.white,
              ),
              Text(
                'Lista',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        if (serie.first.capitulo!.length > capitulo.numeroCapitulo)
          GestureDetector(
            onTap: () async {
              int nuevocap = capitulo.numeroCapitulo + 1;
              await servicioserie.Mostrarcapitulo1(capitulo.serieId, nuevocap);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Capitulo_screen_sin(
                      capitulo: servicioserie.capitulo2.first),
                ),
              );
            },
            child: Column(
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                Text(
                  'Siguiente',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Capitulo capitulomenu;
  final List<Series> serie;
  const _CustomAppBar(
      {super.key, required this.capitulomenu, required this.serie});

  @override
  Widget build(BuildContext context) {
    String cap = serie.first.nombre;
    String numerocap = capitulomenu.numeroCapitulo.toString();
    return SliverAppBar(
      expandedHeight: 50,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Text(
            cap + ' capitulo :' + numerocap,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _Reproductor extends StatefulWidget {
  final Capitulo capitulo;
  const _Reproductor({super.key, required this.capitulo});

  @override
  State<_Reproductor> createState() => __ReproductorState(capitulo);
}

class __ReproductorState extends State<_Reproductor> {
  FlickManager? flickManager;
  final Capitulo capitulo;

  __ReproductorState(this.capitulo);
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    );
  }

  @override
  void dispose() {
    flickManager!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: FlickVideoPlayer(flickManager: flickManager!),
    );
  }
}
