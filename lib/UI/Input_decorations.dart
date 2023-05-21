import 'package:flutter/material.dart';

class InputDecotations {
  static InputDecoration authInputDecotation({
    required String hintText,
    required String labelText,
    IconData? icono,
  }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon:
            icono != null ? Icon(icono, color: Colors.deepPurple) : null);
  }
}
