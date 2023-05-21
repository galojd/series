import 'package:flutter/material.dart';
import 'package:series/widgets/auth_background.dart';

import '../UI/Input_decorations.dart';
import '../widgets/widgets.dart';

class Actualizar extends StatelessWidget {
  const Actualizar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250),
            CardContainer(
              child: Column(children: const [
                SizedBox(height: 10),
                Text('Actualiza tus datos',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                SizedBox(height: 30),
                _Actualizala()
              ]),
            )
          ],
        ),
      )),
    );
  }
}

class _Actualizala extends StatelessWidget {
  const _Actualizala({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          child: Column(
        children: [
          TextFormField(
            //como es para correo no quiere que este corrigiendo
            autocorrect: false,
            style: TextStyle(color: Colors.black),
            keyboardType: TextInputType.name,
            //la persona no puede ver los caracteres
            decoration: InputDecotations.authInputDecotation(
                hintText: 'Nombre',
                labelText: 'Ingresar Nombre',
                icono: Icons.man_outlined),
            validator: (value) {
              if (value != null) {
                return null;
              } else {
                return 'El minimo de caracteres es 6';
              }
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            //como es para correo no quiere que este corrigiendo
            autocorrect: false,
            style: TextStyle(color: Colors.black),
            keyboardType: TextInputType.name,
            //la persona no puede ver los caracteres
            decoration: InputDecotations.authInputDecotation(
                hintText: 'Apellido',
                labelText: 'Ingresar Apellido',
                icono: Icons.man_outlined),

            validator: (value) {
              if (value != null) {
                return null;
              } else {
                return 'El minimo de caracteres es 6';
              }
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            //como es para correo no quiere que este corrigiendo
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black),
            decoration: InputDecotations.authInputDecotation(
                hintText: 'correogenerico@gmail.com',
                labelText: 'Ingresar correo',
                icono: Icons.alternate_email),
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = new RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Formato de correo incorrecto';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            //como es para correo no quiere que este corrigiendo
            autocorrect: false,
            style: TextStyle(color: Colors.black),
            keyboardType: TextInputType.visiblePassword,
            //la persona no puede ver los caracteres
            obscureText: true,
            decoration: InputDecotations.authInputDecotation(
                hintText: '************',
                labelText: 'Ingresar contraseña',
                icono: Icons.looks_3_outlined),
            validator: (value) {
              if (value != null && value.length >= 6) {
                return null;
              } else {
                return 'El minimo de caracteres es 6';
              }
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            //como es para correo no quiere que este corrigiendo
            autocorrect: false,
            style: TextStyle(color: Colors.black),
            keyboardType: TextInputType.name,
            //la persona no puede ver los caracteres
            decoration: InputDecotations.authInputDecotation(
                hintText: 'Nombre de usuario',
                labelText: 'Ingresar Nombre de Usuario',
                icono: Icons.supervised_user_circle),
            validator: (value) {
              if (value != null) {
                return null;
              } else {
                return 'El minimo de caracteres es 6';
              }
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            color: Colors.amber,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                'Registrar',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            onPressed: () => Navigator.pushReplacementNamed(context, 'home2'),
          )
        ],
      )),
    );
  }
}
