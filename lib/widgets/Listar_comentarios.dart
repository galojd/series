import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lista_Comentarios extends StatelessWidget {
  final List<dynamic> listadocomentario;
  const Lista_Comentarios({super.key, required this.listadocomentario});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 310,
      //color: Colors.red,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: listadocomentario.length,
                  itemBuilder: ((context, index) => _Listando(
                        listadocomentario1: listadocomentario[index],
                      ))))
        ],
      ),
    );
  }
}

class _Listando extends StatelessWidget {
  final dynamic listadocomentario1;
  const _Listando({
    Key? key,
    required this.listadocomentario1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String textodecomentario = listadocomentario1['comentarioTexto'];
    final String usuariocomentario = listadocomentario1['userName'];
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(usuariocomentario),
              Container(
                width: 310,
                height: 50,
                child: Text(
                  textodecomentario,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
