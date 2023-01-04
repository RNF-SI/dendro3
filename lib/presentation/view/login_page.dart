// import 'package:authentication_riverpod/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dendro3/presentation/viewmodel/auth/auth_viewmodel.dart';

import '../../domain/model/user.dart';

enum Status {
  login,
}

Status type = Status.login;

//  I have used stateful widget to use setstate functions in LoginPage
//  we could also managed the state using Riverpod but I am not using it here
//  Remember Stateful widgets are made for a reason. If it would be bad
//  flutter developer would not think of it in the first place.

class LoginPage extends StatefulWidget {
  User? _user;

  LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthenticationViewModel _viewModel;

  //  GlobalKey is used to validate the Form
  final GlobalKey<FormState> _formKey = GlobalKey();

  //  TextEditingController to get the data from the TextFields
  //  we can also use Riverpod to manage the state of the TextFields
  //  but again I am not using it here
  final _identifiant = TextEditingController();
  final _password = TextEditingController();

  _LoginPageState();

  @override
  void initState() {
    super.initState();
  }

  //  A loading variable to show the loading animation when you a function is ongoing
  bool _isLoading = false;

  void loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer(builder: (context, ref, _) {
          //  Consuming a provider using watch method and storing it in a variable
          //  Now we will use this variable to access all the functions of the
          //  authentication
          final auth = ref.watch(authenticationViewModelProvider);

          //  Instead of creating a clutter on the onPressed Function
          //  I have decided to create a seperate function and pass them into the
          //  respective parameters.
          //  if you want you can write the exact code in the onPressed function
          //  it all depends on personal preference and code readability
          Future<void> _onPressedFunction() async {
            if (_formKey.currentState!.validate()) {
              loading();
              await auth.signInWithEmailAndPassword(
                  _identifiant.text, _password.text, context);
              loading();
            }
          }

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(top: 48),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(child: FlutterLogo(size: 81)),
                        const Spacer(flex: 1),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: TextFormField(
                            controller: _identifiant,
                            autocorrect: true,
                            enableSuggestions: true,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {},
                            decoration: InputDecoration(
                              hintText: 'Identifiant',
                              hintStyle: const TextStyle(color: Colors.black54),
                              icon: Icon(Icons.email_outlined,
                                  color: Colors.blue.shade700, size: 24),
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "L'identifiant est nécessaire";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: TextFormField(
                            controller: _password,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Le mot de passe est nécessaire';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.black54),
                              icon: Icon(CupertinoIcons.lock_circle,
                                  color: Colors.blue.shade700, size: 24),
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 32.0),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            width: double.infinity,
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : MaterialButton(
                                    onPressed: _onPressedFunction,
                                    textColor: Colors.blue.shade700,
                                    textTheme: ButtonTextTheme.primary,
                                    minWidth: 100,
                                    padding: const EdgeInsets.all(18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: BorderSide(
                                          color: Colors.blue.shade700),
                                    ),
                                    child: Text(
                                      type == Status.login
                                          ? 'Log in'
                                          : 'Sign up',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                          ),
                          const Spacer(),
                        ],
                      )),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
