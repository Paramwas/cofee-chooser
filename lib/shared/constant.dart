import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

const textInputDeco = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintText: 'enter email',
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2)));

const textEmailDeco = InputDecoration(
    hintText: 'password',
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2.0)));
