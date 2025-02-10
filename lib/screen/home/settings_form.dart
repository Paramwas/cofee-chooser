import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore Import
import 'package:kendrick/models/details.dart';
import 'package:kendrick/models/user.dart';
import 'package:kendrick/services/auth.dart';
import 'package:kendrick/services/database.dart';
import 'package:kendrick/shared/constant.dart';

class settingsForm extends ConsumerStatefulWidget {
  const settingsForm({super.key});

  @override
  ConsumerState<settingsForm> createState() => _settingsFormState();
}

class _settingsFormState extends ConsumerState<settingsForm> {
  final formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName = '';
  String _currentSugars = '';
  int? _currentStrength;
  List<Bujus> wakati = [];
  String uidd = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    payn();
  }

  Future<void> payn() async {
    final toast = ref.read(authStateProvider);

    DocumentSnapshot<Map<String, dynamic>> kiasi = await FirebaseFirestore
        .instance
        .collection('brews')
        .doc(toast.value)
        .get();

    print("Document data: ${kiasi.data()}");

    if (kiasi.exists) {
      setState(() {
        // Using the actual fields from Firestore
        wakati = [Bujus.fromMap(kiasi.data()!)];
      });
    } else {
      print("⚠️ Document does not exist.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final toast = ref.read(authStateProvider);
    if (toast.hasValue) {
      setState(() {
        uidd = toast.value ?? '';
      });
    }

    final wine = ref.watch(naughtyProvider);

    return Scaffold(
        body: Column(
      children: wakati.map((wine) {
        return Column(
          spacing: 20,
          children: [
            Form(
                child: TextFormField(
              initialValue: wine.name,
              decoration: textEmailDeco.copyWith(hintText: wine.name),
              onChanged: (value) => setState(() {
                _currentName = value;
              }),
            )),
            Slider(
                activeColor: Colors.brown[_currentStrength ?? wine.strength],
                inactiveColor: Colors.brown[_currentStrength ?? wine.strength],
                divisions: 8,
                value: (_currentStrength ?? wine.strength).toDouble(),
                min: 100.0,
                max: 900.0,
                onChanged: (place) {
                  setState(() {
                    _currentStrength = place.round();
                  });
                }),
            DropdownButtonFormField(
              value: _currentSugars.isNotEmpty
                  ? _currentSugars
                  : '${wine.sugars}', // Ensure a valid initial value
              items: sugars
                  .map((smokes) => DropdownMenuItem(
                        value: smokes, // Add this to set the correct value
                        child: Text(smokes),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _currentSugars = newValue ?? '0';
                });
              },
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                onPressed: () {
                  DatabaseService(uid: uidd).updateUserData(
                    _currentSugars,
                    _currentName,
                    _currentStrength ?? 100,
                  );
                  print(_currentName);
                  print(_currentStrength);
                  print(_currentSugars);
                },
                child: Text('press'))
          ],
        );
      }).toList(),
    ));
  }
}
