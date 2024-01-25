import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import '../../../core/validate/account_validator.dart';
import '../../../generated/assets.dart';
import '../../domain/entity/account.dart';
import '../widget/rounded_text_field.dart';
import '../bloc/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  Artboard? _artboard;
  late final SMITrigger _successTrigger, _failTrigger;
  late final SMIBool _isHandUp, _isChecking;
  late final SMINumber _numLook;

  late StateMachineController _stateController;

  String? emailError;
  String? passwordError;
  bool canLogin = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Stack(
            children: [
              Row(
                children: [
                  if (size.width > 800)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Center(
                          child: Text(
                            'Trapper',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 300,
                          width: 300,
                          child: Center(
                            child: _artboard != null
                                ? Rive(
                                    artboard: _artboard!,
                                    fit: BoxFit.cover,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primaryContainer, width: 2), borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                RoundedTextField(
                                  labelText: 'Email',
                                  hintText: 'example@gmail.com',
                                  errorText: emailError,
                                  obscureText: false,
                                  controller: _email,
                                  onTap: lookOn,
                                  onChanged: lookFollow,
                                  onTapOutside: (event) => stopLooking(),
                                ),
                                const SizedBox(height: 16),
                                RoundedTextField(
                                  labelText: "Password",
                                  hintText: "********",
                                  errorText: passwordError,
                                  obscureText: true,
                                  controller: _password,
                                  onTap: handOn,
                                  onTapOutside: (event) => stopLooking(),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                    onPressed: () {
                                      if (canLogin) {
                                        login();
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      child: const Text('Login'),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (state is AuthStateLoading)
                Container(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();

    rootBundle.load(Assets.riveBear).then((value) {
      final file = RiveFile.import(value);
      final artboard = file.mainArtboard;
      _stateController = StateMachineController.fromArtboard(artboard, 'Login Machine')!;
      _artboard = artboard;
      _artboard!.addController(_stateController);

      for (var element in _stateController.inputs) {
        if (element.name == 'isHandsUp') {
          _isHandUp = element as SMIBool;
        } else if (element.name == 'isChecking') {
          _isChecking = element as SMIBool;
        } else if (element.name == 'numLook') {
          _numLook = element as SMINumber;
        } else if (element.name == 'trigSuccess') {
          _successTrigger = element as SMITrigger;
        } else if (element.name == 'trigFail') {
          _failTrigger = element as SMITrigger;
        }
      }

      setState(() {
        _artboard = artboard;
      });
    });

    _email.addListener(() {
      setState(() {
        emailError = AccountValidator.validateEmail(_email.text);
        canLogin = emailError == null && passwordError == null;
      });
    });

    _password.addListener(() {
      setState(() {
        passwordError = AccountValidator.validatePassword(_password.text);
        canLogin = emailError == null && passwordError == null;
      });
    });

    context.read<AuthBloc>().stream.listen((state) {
      print(state.runtimeType);
      if (state is AuthStateAuthenticated) {
        _successTrigger.fire();
      } else if (state is AuthStateFailure) {
        _failTrigger.fire();
      }
    });
  }

  void handOn() {
    _isHandUp.change(true);
  }

  void stopLooking() {
    _isChecking.change(false);
    _isHandUp.change(false);
  }

  void lookOn() {
    _isChecking.change(true);
    _isHandUp.change(false);
    _numLook.change(0);
  }

  void lookFollow(String value) {
    _numLook.change(value.length.toDouble());
  }

  void login() {
    _isChecking.change(false);
    _isHandUp.change(false);
    context.read<AuthBloc>().add(
          AuthEventLogin(
            account: Account(
              email: _email.text,
              password: _password.text,
            ),
          ),
        );
  }
}
