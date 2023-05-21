import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

import '../widgets/widgets.dart';

class Capitulo_screen extends StatefulWidget {
  @override
  State<Capitulo_screen> createState() => _Capitulo_screenState();
}

class _Capitulo_screenState extends State<Capitulo_screen> {
  @override
  Widget build(BuildContext context) {
    final String capitulo =
        ModalRoute.of(context)!.settings.arguments.toString() ?? 'No capitulo';
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 30,
            ),
            _Reproductor(),
            SizedBox(
              height: 30,
            ),
            _Sub_Menu(),
            SizedBox(
              height: 30,
            ),
            Text('Comentarios',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Lista_Comentarios()
          ]))
        ],
      ),
    );
  }
}

class _Sub_Menu extends StatelessWidget {
  const _Sub_Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
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
        Column(
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
        Column(
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
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: const Text(
            'Monster Hunter Cap N',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _Reproductor extends StatefulWidget {
  const _Reproductor({super.key});

  @override
  State<_Reproductor> createState() => __ReproductorState();
}

class __ReproductorState extends State<_Reproductor> {
  FlickManager? flickManager;
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
