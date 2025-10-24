import 'package:flutter/material.dart';

TextFormField text_box ({
  required TextInputType Type,
  required String Label,
  required Icon Prefix,
  Icon? Postfix,
}){
  return TextFormField(
    keyboardType: Type,
    decoration: InputDecoration(
      label: Text(Label),
      border: OutlineInputBorder(),
      prefixIcon: Prefix,
      suffixIcon: Postfix,
    ),
  );
}