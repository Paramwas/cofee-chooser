import 'package:flutter/foundation.dart';

class Bujus {
  final String name;
  final String sugars;
  final int strength;

  Bujus({required this.name, required this.strength, required this.sugars});

  factory Bujus.fromMap(Map<String, dynamic> data) {
    return Bujus(
      name: data['name'] ?? '',
      strength: data['strength'] ?? 0, // Default to 0 if missing
      sugars: data['sugars'] ?? '',
    );
  }
}
