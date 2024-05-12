import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../utils/validator.dart';
import '../../../../domain/entity/account.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../bloc/profile/profile_bloc.dart';
import 'rounded_text_field.dart';

class ChangePasswordBox extends StatefulWidget {
  const ChangePasswordBox({super.key});

  @override
  State<ChangePasswordBox> createState() => _ChangePasswordBoxState();
}

class _ChangePasswordBoxState extends State<ChangePasswordBox> {
  late TextEditingController _oldPassword;
  late TextEditingController _password;
  late TextEditingController _confirmPassword;

  String? _oldPasswordErrorText;
  String? _passwordErrorText;
  String? _confirmPasswordErrorText;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AuthStateChangePasswordSuccessful) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, authState) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundedTextField(
                  obscureText: true,
                  enabled: authState is! AuthStateLoading,
                  hintText: S.current.password_example,
                  label: S.current.old_password,
                  controller: _oldPassword,
                  errorText: _oldPasswordErrorText,
                ),
                RoundedTextField(
                  obscureText: true,
                  enabled: authState is! AuthStateLoading,
                  hintText: S.current.password_example,
                  label: S.current.new_password,
                  controller: _password,
                  errorText: _passwordErrorText,
                ),
                RoundedTextField(
                  obscureText: true,
                  hintText: S.current.password_example,
                  label: S.current.confirm_password,
                  controller: _confirmPassword,
                  errorText: _confirmPasswordErrorText,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(S.current.cancel),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (authState is! AuthStateLoading &&
                            _passwordErrorText == null &&
                            _confirmPasswordErrorText == null &&
                            _password.text.isNotEmpty &&
                            _confirmPassword.text.isNotEmpty) {
                          _changePassword();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: authState is AuthStateLoading
                            ? const RefreshProgressIndicator(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              )
                            : Text(_buildButtonText(authState)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _oldPassword = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();

    _oldPassword.addListener(
      () => setState(() {
        _oldPasswordErrorText = Validator.password(_oldPassword.text);
      }),
    );
    _password.addListener(
      () => setState(() {
        _passwordErrorText =
            Validator.password(_password.text, checker: _confirmPassword.text);
        _confirmPasswordErrorText =
            Validator.password(_confirmPassword.text, checker: _password.text);
      }),
    );
    _confirmPassword.addListener(
      () => setState(() {
        _confirmPasswordErrorText =
            Validator.password(_confirmPassword.text, checker: _password.text);
        _passwordErrorText =
            Validator.password(_password.text, checker: _confirmPassword.text);
      }),
    );
  }

  void _changePassword() {
    context.read<AuthBloc>().add(
          AuthEventChangePassword(
            account: Account(
              email: context.read<ProfileBloc>().state.profile.email ?? '',
              password: _oldPassword.text,
            ),
            newPassword: _password.text,
          ),
        );
  }

  String _buildButtonText(AuthState state) {
    return S.current.change_password;
  }

  @override
  void dispose() {
    _oldPassword.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
}
