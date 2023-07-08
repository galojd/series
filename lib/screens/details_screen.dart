import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/widgets/widgets.dart';
import '../models/models.dart';
import '../services/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Details_Screen extends StatefulWidget {
  final Series lista;

  const Details_Screen({Key? key, required this.lista}) : super(key: key);

  @override
  State<Details_Screen> createState() => _Details_ScreenState();
}

class _Details_ScreenState extends State<Details_Screen> {
  List<dynamic> comentarios = [];
  bool _botonEncendido = false;

  //List<bool> _isSelected = [false, false];
  @override
  void initState() {
    super.initState();
    comentarios = widget.lista.textoComentario ?? [];
  }

  void agregarComentario(dynamic comentario) {
    setState(() {
      comentarios.add(comentario);
    });
  }

  @override
  Widget build(BuildContext context) {
    final servicioserie = Provider.of<SeriesService>(context, listen: false);
    final FlutterSecureStorage storage = FlutterSecureStorage();

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => ButtonState(servicioserie, widget.lista.serieId),
        child: Builder(
          builder: (context) {
            final buttonState = Provider.of<ButtonState>(context);
            final isButtonOn = buttonState.isButtonOn;

            return CustomScrollView(
              slivers: [
                _CustomAppBar(listalo: widget.lista),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 20),
                    _Sinopsis(listalo1: widget.lista),
                    SizedBox(height: 20),
                    Text(
                      'Capitulos',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    lista_Cap_Log(
                      listadocapitulo: widget.lista.capitulo!,
                      serie: widget.lista,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: isButtonOn
                            ? MaterialStateProperty.all<Color>(Colors.green)
                            : MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: () async {
                        String usuarioId = await storage.read(key: 'userid') ??
                            'no hay no exite';

                        buttonState.toggleButton();
                        print('Estado actualizado: ${buttonState.isButtonOn}');

                        if (buttonState.isButtonOn) {
                          await servicioserie.AgregarSerieUsuario(
                              usuarioId, widget.lista.serieId);
                          print('Siguiendo');
                        } else {
                          await servicioserie.EliminarSerieUsuario(
                              usuarioId, widget.lista.serieId);
                          print('Dejó de seguir');
                        }
                      },
                      child: Text(
                        isButtonOn ? 'Siguiendo' : 'Seguir',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Comentarios',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ComentarioInput(
                      onComentarioAgregado: agregarComentario,
                      lista: widget.lista,
                    ),
                    Lista_Comentarios(listadocomentario: comentarios),
                  ]),
                ),
              ],
            );
          },
        ),
      ),
    );
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

class ButtonState extends ChangeNotifier {
  final SeriesService servicioserie;
  final String serieId;

  bool _isButtonOn = false;

  ButtonState(this.servicioserie, this.serieId) {
    final int contador = servicioserie.usuariodeserie.length;

    for (int i = 0; i < contador; i++) {
      if (servicioserie.usuariodeserie[i].serieId == serieId) {
        _isButtonOn = true;
        break;
      }
    }
  }

  bool get isButtonOn => _isButtonOn;

  void toggleButton() {
    _isButtonOn = !_isButtonOn;
    notifyListeners();
  }
}
