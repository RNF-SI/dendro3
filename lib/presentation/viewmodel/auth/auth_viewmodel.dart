import 'dart:async';

import 'package:dendro3/domain/domain_module.dart';

import 'package:dendro3/presentation/state/state.dart' as dendroState;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dendro3/domain/usecase/login_usecase.dart';

import 'package:dendro3/domain/model/user.dart';

import '../../../domain/model/authentication.dart';

// Pour le Checker
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationViewModelProvider).authStateChange;
});

final authenticationViewModelProvider =
    Provider<AuthenticationViewModel>((ref) {
  return AuthenticationViewModel(
    ref.watch(loginUseCaseProvider),
  );
});

class AuthenticationViewModel extends StateNotifier<dendroState.State<User>> {
  var _email = '';
  var _password = '';

  User? user;

  StreamController<User?> controller = StreamController<User?>();

  final LoginUseCase _loginUseCase;

  AuthenticationViewModel(this._loginUseCase)
      : super(const dendroState.State.init()) {
    controller.add(user);
  }

  Stream<User?> get authStateChange => controller.stream;

  Future<void> signInWithEmailAndPassword(final String identifiant,
      final String password, BuildContext context) async {
    try {
      state = const dendroState.State.loading();
      await _loginUseCase
          .execute(identifiant, password)
          .then((evt) => controller.add(evt));
    } on DioError catch (e) {
      var errorObj = {};
      var errorText;
      if (e.response != null) {
        errorObj['data'] = e.response!.data;
        errorObj['headers'] = e.response!.headers;
        errorObj['requestOptions'] = e.response!.requestOptions;
        errorText =
            "${e.error} : Le serveur a été atteint, mais ce dernier a renvoyé une exception";
      } else {
        errorObj['message'] = e.message;
        errorObj['requestOptions'] = e.requestOptions;
        errorText =
            "${e.error}: La requète n'a pas pu être mise en place ou envoyée";
      }
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(errorText),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: errorObj.length,
              itemBuilder: (BuildContext context, int index) {
                String key = errorObj.keys.elementAt(index);
                return new Column(
                  children: <Widget>[
                    new ListTile(
                      title: new Text("$key"),
                      subtitle: new Text("${errorObj[key]}"),
                    ),
                    new Divider(
                      height: 2.0,
                    ),
                  ],
                );
              },
            ),
          ),
          // content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    } on Exception catch (e) {
      state = dendroState.State.error(e);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
      // state = State.error(e);
    }
  }
}
