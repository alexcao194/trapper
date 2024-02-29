import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:go_router/go_router.dart';
import 'package:trapper/config/const/dimen.dart';
import 'package:trapper/config/go_router/app_go_router.dart';
import 'package:trapper/utils/dialog_tools.dart';
import '../../../utils/validator.dart';
import '../../../generated/assets.dart';
import '../../domain/entity/account.dart';
import '../widget/rounded_text_field.dart';
import '../bloc/auth/auth_bloc.dart';
import '../../../generated/l10n.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushReplacementNamed(RoutePath.messages);
        },
        child: const Icon(Icons.home),
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateAuthenticated) {
              _successTrigger.fire();
              context.go(RoutePath.home);
            } else if (state is AuthStateFailure) {
              _failTrigger.fire();
              DialogTools.showFailureDialog(context, message: state.error);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Row(
                  children: [
                    if (size.width > Dimen.mobileWidth)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Text(
                                S.current.app_name,
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
                                    labelText: S.current.email,
                                    hintText: S.current.email_example,
                                    errorText: emailError,
                                    controller: _email,
                                    prefixIcon: const Icon(Icons.email_outlined, size: 18),
                                    onTap: lookOn,
                                    onChanged: lookFollow,
                                    onTapOutside: (event) => stopLooking(),
                                  ),
                                  const SizedBox(height: 16),
                                  RoundedTextField(
                                    labelText: S.current.password,
                                    hintText: S.current.password_example,
                                    prefixIcon: const Icon(Icons.lock_outline, size: 18),
                                    errorText: passwordError,
                                    obscureText: true,
                                    controller: _password,
                                    onTap: handOn,
                                    onTapOutside: (event) => stopLooking(),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if (canLogin) {
                                            login();
                                          } else {
                                            DialogTools.showFailureDialog(context, message: S.current.common_fields_error);
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(S.current.login),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: signup,
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(S.current.signup),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            S.current.app_name_annotation,
                            style: Theme.of(context).textTheme.labelMedium,
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
        ),
      ),
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
        emailError = Validator.email(_email.text);
        updateLoginStatus();
      });
    });

    _password.addListener(() {
      setState(() {
        passwordError = Validator.password(_password.text);
        updateLoginStatus();
      });
    });
  }

  void handOn() {
    _isHandUp.change(true);
  }

  void updateLoginStatus() {
    canLogin = emailError == null && passwordError == null && _email.text.isNotEmpty && _password.text.isNotEmpty;
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

  void signup() {
    _isChecking.change(false);
    _isHandUp.change(false);
    DialogTools.showSignupDialog(context);
  }
}
