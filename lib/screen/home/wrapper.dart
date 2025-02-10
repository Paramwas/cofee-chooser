import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kendrick/screen/authenticate/authenticate.dart';
import 'package:kendrick/screen/authenticate/signin.dart';
import 'package:kendrick/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:kendrick/services/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class Wrapper extends ConsumerStatefulWidget {
  const Wrapper({super.key});

  @override
  ConsumerState<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends ConsumerState<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final thegy = ref.watch(authStateProvider);
    print(thegy);

    if (thegy.isLoading) {
      return CircularProgressIndicator();
    }
    if (thegy.hasError) {
      return Scaffold(
        body: Center(child: Text('Error: ${thegy.error}')),
      );
    }

    final usecase = thegy.value;

    if (usecase == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
