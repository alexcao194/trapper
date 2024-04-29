import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/const/dimen.dart';
import '../../../../config/go_router/app_go_router.dart';
import '../../../../utils/dialog_tools.dart';
import '../../../../utils/validator.dart';
import '../../../../generated/assets.dart';
import '../../../domain/entity/account.dart';
import 'widget/outline_text_field.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../di.dart';
import '../widgets/side_banner.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const EMAIL_KEY = 'email';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

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
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateAuthenticated) {
              try {
                _successTrigger.fire();
              } catch (e) {
                debugPrint(e.toString());
              }
              context.go(RoutePath.home);
            } else if (state is AuthStateFailure) {
              if (state.error != null) {
                _failTrigger.fire();
                DialogTools.showFailureDialog(context, message: state.error!);
              }
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              primary: true,
              child: Stack(
                children: [
                  SizedBox(
                    height: size.height,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (size.width > Dimen.mobileWidth)
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                child: Center(child: SlideBanner(size: size)),
                              ),
                            ),
                          ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 300,
                                height: size.width > Dimen.mobileWidth ? 300 : null,
                                child: Center(child: getChar()),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primaryContainer, width: 2), borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      OutlineTextField(
                                        textInputAction: TextInputAction.next,
                                        inputType: TextInputType.emailAddress,
                                        focusNode: _emailFocusNode,
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
                                      OutlineTextField(
                                        textInputAction: TextInputAction.done,
                                        inputType: TextInputType.visiblePassword,
                                        focusNode: _passwordFocusNode,
                                        labelText: S.current.password,
                                        hintText: S.current.password_example,
                                        prefixIcon: const Icon(Icons.lock_outline, size: 18),
                                        errorText: passwordError,
                                        obscureText: true,
                                        controller: _password,
                                        onTap: handOn,
                                        onTapOutside: (event) => stopLooking(),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: MaterialButton(
                                          padding: const EdgeInsets.symmetric(vertical: 18),
                                          hoverColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onPressed: () {
                                            _onForgotPassword();
                                          },
                                          child: Text(S.current.forgot_password,
                                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                    color: Theme.of(context).colorScheme.primary,
                                                  )),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                            ),
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
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                            ),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state is AuthStateLoading)
                    Container(
                      height: size.height,
                      width: size.width,
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                      child: Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: Theme.of(context).colorScheme.primary,
                          size: 50,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    var cachedEmail = DependencyInjection.sl<SharedPreferences>().getString(LoginScreen.EMAIL_KEY);
    if (cachedEmail != null) {
      _email.text = cachedEmail;
    }

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

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

      if (mounted) {
        setState(() {
          _artboard = artboard;
        });
      }

      _passwordFocusNode.addListener(() {
        if (_passwordFocusNode.hasFocus) {
          _isHandUp.change(true);
        } else {
          _isHandUp.change(false);
        }
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
    super.initState();
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
    if (emailError == null) {
      DependencyInjection.sl<SharedPreferences>().setString(LoginScreen.EMAIL_KEY, _email.text);
    }
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

  Widget getChar() {
    if (MediaQuery.of(context).size.width > Dimen.mobileWidth) {
      return _artboard != null
          ? Rive(
              artboard: _artboard!,
              fit: BoxFit.cover,
            )
          : const SizedBox();
    } else {
      return SlideBanner(size: MediaQuery.of(context).size);
    }
  }

  void _onForgotPassword() {
    context.read<AuthBloc>().add(const AuthEventForgotPassword());
    DialogTools.showForgotPasswordDialog(context);
  }
}
