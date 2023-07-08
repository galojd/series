import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/models/models.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import '../services/series_services.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

//Este capituloscreen es para las opciones sin logeo, este es las opciones de submenu dentro de las series
class Capitulo_screen_Serie extends StatefulWidget {
  final dynamic capitulo;
  final Series listaserie;

  const Capitulo_screen_Serie(
      {super.key, required this.capitulo, required this.listaserie});
  @override
  State<Capitulo_screen_Serie> createState() =>
      _Capitulo_screenState(capitulo, listaserie);
}

class _Capitulo_screenState extends State<Capitulo_screen_Serie> {
  final dynamic capitulo1;
  final Series serie;
  String nuevoComentario = '';

  _Capitulo_screenState(this.capitulo1, this.serie);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            capitulomenu: capitulo1,
            seie: serie,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 30,
            ),
            _Reproductor(
              capitulo1: capitulo1,
            ),
            SizedBox(
              height: 30,
            ),
            _Sub_Menu(
              listala: serie,
              capitulo: capitulo1,
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
            _Lista_Comentarios(
              listadocomentario: capitulo1,
            )
          ]))
        ],
      ),
    );
  }
}

class _Lista_Comentarios extends StatelessWidget {
  final dynamic listadocomentario;

  const _Lista_Comentarios({Key? key, required this.listadocomentario});

  @override
  Widget build(BuildContext context) {
    List<dynamic> comentarios = listadocomentario['textoComentario'];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: comentarios.length,
      itemBuilder: (context, index) {
        dynamic comentario = comentarios[index];
        String comentarioTexto = comentario['comentarioTexto'];
        String userName = comentario['userName'];

        return ListTile(
          title: Text(comentarioTexto),
          subtitle: Text(userName),
        );
      },
    );
  }
}

class _Sub_Menu extends StatelessWidget {
  final Series listala;
  final dynamic capitulo;
  const _Sub_Menu({
    Key? key,
    required this.listala,
    required this.capitulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final servicioserie = Provider.of<SeriesService>(context);
    final int numerocap = capitulo['numeroCapitulo'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (numerocap > 1)
          GestureDetector(
            onTap: () async {
              int nuevocap1 = numerocap - 1;
              await servicioserie.Mostrardatosdeserie(listala.serieId);
              await servicioserie.Mostrarcapitulo1(listala.serieId, nuevocap1);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Capitulo_screen_sin1(
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
                builder: (context) => Details_Screen_Sin(
                  lista: listala,
                ),
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
        if (listala.capitulo!.length > numerocap)
          GestureDetector(
            onTap: () async {
              int nuevocap1 = numerocap + 1;
              await servicioserie.Mostrardatosdeserie(listala.serieId);
              await servicioserie.Mostrarcapitulo1(listala.serieId, nuevocap1);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Capitulo_screen_sin1(
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
  final dynamic capitulomenu;
  final Series seie;
  const _CustomAppBar(
      {super.key, required this.capitulomenu, required this.seie});

  @override
  Widget build(BuildContext context) {
    final String cap = seie.nombre;
    final String numerocap = capitulomenu['numeroCapitulo'].toString();
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
  final dynamic capitulo1;
  const _Reproductor({super.key, required this.capitulo1});

  @override
  State<_Reproductor> createState() => __ReproductorState(capitulo1);
}

class __ReproductorState extends State<_Reproductor> {
  FlickManager? flickManager;
  final dynamic capitulo1;

  __ReproductorState(this.capitulo1);
  @override
  void initState() {
    super.initState();
    String cap = capitulo1['capituloUrl'];
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(cap),
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
