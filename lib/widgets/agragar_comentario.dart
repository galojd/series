import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:series/services/services.dart';

import '../models/models.dart';

class ComentarioInput extends StatefulWidget {
  final Series lista;
  final Function(dynamic) onComentarioAgregado; // Nueva propiedad

  ComentarioInput(
      {super.key, required this.lista, required this.onComentarioAgregado});
  @override
  _ComentarioInputState createState() => _ComentarioInputState(lista);
}

class _ComentarioInputState extends State<ComentarioInput> {
  final Series lista;
  final TextEditingController _controller = TextEditingController();
  final AuthService _authService = AuthService(); // Instancia de AuthService
  final FlutterSecureStorage storage = FlutterSecureStorage();
  bool comentarioEnviado = false;

  _ComentarioInputState(this.lista);

  // Aquí puedes definir tu lógica de conexión al servidor

  void _enviarComentario() async {
    if (comentarioEnviado) {
      // Si el comentario ya ha sido enviado, no hacer nada
      return;
    }
    String comentario = _controller.text;
    String serieId = lista.serieId; // Obtén el ID de la serie desde el widget
    String usuarioId = await storage.read(key: 'userid') ??
        'no hay no exite'; // Obtén el ID de usuario correspondiente

    String userName = await storage.read(key: 'username') ??
        'lastima no lo lee'; // Obtén el nombre de usuario correspondiente
    String token = await storage.read(key: 'idtoken') ?? 'lastima no lo lee';

    // Lógica para enviar el comentario al servidor
    // ...
    // Aquí puedes usar servicios, llamadas a API, etc.
    // Lógica para enviar el comentario al servidor
    // Lógica para enviar el comentario al servicio SeriesService

    final seriesService = SeriesService();
    await seriesService.AgregarComentario(
        comentario, usuarioId, serieId, null, userName, token);

    setState(() {
      comentarioEnviado = true;
    });

    // Lógica para agregar el comentario a la lista en Details_Screen
    widget.onComentarioAgregado(
        {'comentarioTexto': comentario, 'userName': userName});

    _controller.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      comentarioEnviado = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: 'Ingrese su comentario...',
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: _enviarComentario,
            child: Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
