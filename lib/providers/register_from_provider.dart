import 'package:flutter/material.dart';

class Registrar_Form_Provider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String email = '';
  String Password = '';
  String Nombre = '';
  String Apellido = '';
  String UserName = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isvalidform() {
    print(formkey.currentState?.validate() ?? false);
    return formkey.currentState?.validate() ?? false;
  }
}
