import 'package:flutter/material.dart';
import '../UI/Input_decorations.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

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
              child: Column(children: [
                const SizedBox(height: 10),
                const Text('Actualiza tus datos',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => Registrar_Form_Provider(),
                  //solo lo que esta en el loginform tendra acceso al loginformprovider
                  child: _Actualizala(),
                ),
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
    final servicioserie = Provider.of<SeriesService>(context, listen: false);
    final registerform = Provider.of<Registrar_Form_Provider>(context);
    return Container(
      child: Form(
          key: registerform.formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                onChanged: (value) => registerform.Nombre = value,
                validator: (value) {
                  if (value == null && value!.isEmpty) {
                    return null;
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

                onChanged: (value) => registerform.Apellido = value,

                validator: (value) {
                  if (value == null && value!.isEmpty) {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                //como es para correo no quiere que este corrigiendo
                autocorrect: false,
                onChanged: (value) => registerform.email = value,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                initialValue: servicioserie.serieusuario.first.email,
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
                keyboardType: TextInputType.emailAddress,
                //la persona no puede ver los caracteres
                obscureText: true,
                decoration: InputDecotations.authInputDecotation(
                    hintText: '************',
                    labelText: 'Ingresar contraseña',
                    icono: Icons.looks_3_outlined),
                onChanged: (value) => registerform.Password = value,
                validator: (value) {
                  if (value == null && value!.isEmpty) {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                //como es para correo no quiere que este corrigiendo
                autocorrect: false,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.name,
                initialValue: servicioserie.serieusuario.first.username,
                enabled: false, // Bloquea el campo para que no sea editable
                //la persona no puede ver los caracteres
                decoration: InputDecotations.authInputDecotation(
                    hintText: 'Nombre de usuario',
                    labelText: 'Nombre de Usuario',
                    icono: Icons.supervised_user_circle),
                onChanged: (value) => registerform.UserName = value,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  } else {
                    return 'Debe ingresar el nombre de usuario deseado';
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    registerform.isLoading ? 'Espere...' : 'Actualizar',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                onPressed: registerform.isLoading
                    ? null
                    : () async {
                        //descativa el boton y cajas cuando se presiona ingresar
                        FocusScope.of(context).unfocus();
                        final authservice =
                            Provider.of<AuthService>(context, listen: false);
                        if (!registerform.isvalidform()) return;
                        registerform.isLoading = true;
                        await Future.delayed(Duration(seconds: 2));
                        final String? mensaje =
                            await authservice.Actualizaruser(
                                registerform.Nombre,
                                registerform.Apellido,
                                registerform.email,
                                registerform.Password,
                                servicioserie.serieusuario.first.username);

                        if (mensaje == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Se actualizo su cuenta exitosamente')));
                          Navigator.pushReplacementNamed(context, 'home2');
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(mensaje)));
                        }
                        /*if (mensaje == 'No se pudo agregar el nuevo usuario') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'la contraseña debe conetener mayusculas, numeros y signos')));
                        }
                        if (mensaje == 'El Email ya esta en uso') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(mensaje!)));
                        }
                        if (mensaje ==
                            'El usuario ya se registro anteriormente') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(mensaje!)));
                        }*/

                        registerform.isLoading = false;
                      },
              )
            ],
          )),
    );
  }
}
