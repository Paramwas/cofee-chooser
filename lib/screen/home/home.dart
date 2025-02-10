import 'package:flutter/material.dart';
import 'package:kendrick/screen/home/settings_form.dart';
import 'package:kendrick/services/auth.dart';
import 'package:kendrick/services/database.dart';
import 'package:kendrick/shared/loading.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kendrick/screen/home/brew_file.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showsetting() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: settingsForm(),
            );
          });
    }

    final munga = ref.watch(WineProvider);
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text('Brew Crew'),
          elevation: 0.0,
          actions: [
            TextButton(
              onPressed: () async {
                await _auth.SignOut();
              },
              child: Text('logout'),
            ),
            TextButton.icon(
                onPressed: () {
                  _showsetting();
                },
                label: Text('setting'))
          ],
        ),
        body: munga.when(
            data: (data) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return BrewTile(brew: data[index]);
                  });
            },
            error: (error, StackTrace) => Center(
                  child: Text('error while loading data'),
                ),
            loading: () => Center(
                  child: Loading(),
                )));
  }
}
