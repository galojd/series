import 'package:flutter/material.dart';

class navegacion_logeo extends StatelessWidget {
  const navegacion_logeo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          child: const Text("Comentar"),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirmación'),
                    content: const Text(
                        'Debe iniciar sesion para comentar, ¿Está seguro de que desea iniciar sesión?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Cerrar el diálogo
                          Navigator.pushReplacementNamed(context, 'login');
                        },
                        child: const Text('Si'),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
