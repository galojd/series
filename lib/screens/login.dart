import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/widgets/widgets.dart';

import '../UI/Input_decorations.dart';
import '../providers/Login_form_provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    //solo lo que esta en el loginform tendra acceso al loginformprovider
                    child: _LoginForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'registrar'),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              child: const Text(
                'Crear una nueva cuenta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginform = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
          key: loginform.formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                //como es para correo no quiere que este corrigiendo
                autocorrect: false,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecotations.authInputDecotation(
                  hintText: 'correogenerico@gmail.com',
                  labelText: 'Ingresar correo',
                  icono: Icons.alternate_email,
                ),
                onChanged: (value) => loginform.email = value,
                validator: ((value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Formato de correo incorrecto';
                }),
              ),
              const SizedBox(height: 30),
              TextFormField(
                //como es para correo no quiere que este corrigiendo
                autocorrect: false,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                //la persona no puede ver los caracteres
                obscureText: true,
                decoration: InputDecotations.authInputDecotation(
                    hintText: '************',
                    labelText: 'Ingresar contraseña',
                    icono: Icons.looks_3_outlined),
                onChanged: (value) => loginform.Password = value,
                validator: (value) {
                  if (value != null && value.length >= 6) {
                    return null;
                  } else {
                    return 'El minimo de caracteres es 6';
                  }
                },
              ),
              const SizedBox(height: 30),
              MaterialButton(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: Text(
                      loginform.isLoading ? 'Espere...' : 'Ingresar',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  onPressed: loginform.isLoading
                      ? null
                      : () async {
                          //descativa el boton y cajas cuando se presiona ingresar
                          FocusScope.of(context).unfocus();
                          if (!loginform.isvalidform()) return;
                          loginform.isLoading = true;
                          await Future.delayed(Duration(seconds: 2));
                          loginform.isLoading = false;
                          Navigator.pushReplacementNamed(context, 'home2');
                        })
            ],
          )),
    );
  }
}
