import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/validator.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../../../generated/l10n.dart';
import 'rounded_text_field.dart';

class ResetPasswordBox extends StatefulWidget {
  const ResetPasswordBox({super.key});

  @override
  State<ResetPasswordBox> createState() => _ResetPasswordBoxState();
}

class _ResetPasswordBoxState extends State<ResetPasswordBox> {
  late TextEditingController _email;
  late TextEditingController _otp;
  late TextEditingController _password;
  late TextEditingController _confirmPassword;

  String? _emailErrorText;
  String? _otpErrorText;
  String? _passwordErrorText;
  String? _confirmPasswordErrorText;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (canPop) {
        if (canPop) {
          context.read<AuthBloc>().add(const AuthEventReset());
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoundedTextField(
                    enabled: state is! AuthStateSentOTP,
                    hintText: S.current.email_example,
                    label: S.current.email,
                    controller: _email,
                    errorText: _emailErrorText,
                  ),
                  if (state is AuthStateSentOTP)
                    RoundedTextField(
                      hintText: S.current.otp_example,
                      label: S.current.otp,
                      controller: _otp,
                      errorText: _otpErrorText,
                      inputType: TextInputType.number,
                    ),
                  if (state is AuthStateSentOTP) RoundedTextField(
                    controller: _password,
                    label: S.current.password,
                    hintText: S.current.password_example,
                    errorText: _passwordErrorText,
                    obscureText: true,
                  ),
                  if (state is AuthStateSentOTP) RoundedTextField(
                    controller: _confirmPassword,
                    label: S.current.confirm_password,
                    hintText: S.current.confirm_password_example,
                    errorText: _confirmPasswordErrorText,
                    obscureText: true,
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
                          if (state is! AuthStateSentOTP && _emailErrorText == null && _email.text.isNotEmpty) {
                            _sendOTP();
                          }

                          if (state is AuthStateSentOTP && _passwordErrorText == null && _confirmPasswordErrorText == null && _password.text.isNotEmpty && _confirmPassword.text.isNotEmpty) {
                            _changePassword();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: state is AuthStateLoading
                              ? const RefreshProgressIndicator(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          )
                              : Text(_buildButtonText(state)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _otp = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();

    _email.addListener(
          () => setState(() {
        _emailErrorText = Validator.email(_email.text);
      }),
    );
    _otp.addListener(
          () => setState(() {
        _otpErrorText = Validator.otp(_otp.text);
      }),
    );
    _password.addListener(
          () => setState(() {
        _passwordErrorText = Validator.password(_password.text, checker: _confirmPassword.text);
        _confirmPasswordErrorText = Validator.password(_confirmPassword.text, checker: _password.text);
      }),
    );
    _confirmPassword.addListener(
          () => setState(() {
        _confirmPasswordErrorText = Validator.password(_confirmPassword.text, checker: _password.text);
        _passwordErrorText = Validator.password(_password.text, checker: _confirmPassword.text);
      }),
    );
  }

  void _sendOTP() {
    context.read<AuthBloc>().add(AuthEventSendOTP(email: _email.text));
  }
  
  void _changePassword() {
    context.read<AuthBloc>().add(AuthEventResetPassword(password: _password.text, otp: _otp.text, email: _email.text));
  }

  String _buildButtonText(AuthState state) {
    if (state is! AuthStateSentOTP) {
      return S.current.send_otp;
    }

    return S.current.change_password;
  }

  @override
  void dispose() {
    _email.dispose();
    _otp.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
}
