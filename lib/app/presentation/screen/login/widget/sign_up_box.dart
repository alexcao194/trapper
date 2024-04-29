import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../config/const/dimen.dart';
import '../../../../../utils/dialog_tools.dart';
import '../../../../../utils/validator.dart';
import '../../../../domain/entity/account.dart';
import '../../../../domain/entity/profile.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../../../generated/l10n.dart';
import 'rounded_text_field.dart';

class SignUpBox extends StatefulWidget {
  const SignUpBox({super.key});

  @override
  State<SignUpBox> createState() => _SignUpBoxState();
}

class _SignUpBoxState extends State<SignUpBox> {
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _confirmPassword;
  late TextEditingController _name;
  late TextEditingController _dateOfBirth;
  late TextEditingController _gender;

  String? _emailErrorText;
  String? _passwordErrorText;
  String? _confirmPasswordErrorText;
  String? _nameErrorText;

  bool _canSignup = false;

  bool? _genderValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateAuthenticated) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoundedTextField(
                      hintText: S.current.email_example,
                      label: S.current.email,
                      controller: _email,
                      errorText: _emailErrorText,
                    ),
                    if (size.width > Dimen.mobileWidth)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RoundedTextField(
                              controller: _password,
                              label: S.current.password,
                              hintText: S.current.password_example,
                              errorText: _passwordErrorText,
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: RoundedTextField(
                              controller: _confirmPassword,
                              label: S.current.confirm_password,
                              hintText: S.current.confirm_password_example,
                              errorText: _confirmPasswordErrorText,
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    if (size.width <= Dimen.mobileWidth) ...[
                      RoundedTextField(
                        controller: _password,
                        label: S.current.password,
                        hintText: S.current.password_example,
                        errorText: _passwordErrorText,
                        obscureText: true,
                      ),
                      const SizedBox(width: 8),
                      RoundedTextField(
                        controller: _confirmPassword,
                        label: S.current.confirm_password,
                        hintText: S.current.confirm_password_example,
                        errorText: _confirmPasswordErrorText,
                        obscureText: true,
                      ),
                    ],
                    RoundedTextField(
                      controller: _name,
                      label: S.current.full_name,
                      hintText: S.current.full_name_example,
                      errorText: _nameErrorText,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: pickADate,
                            child: RoundedTextField(
                              controller: _dateOfBirth,
                              label: S.current.date_of_birth,
                              hintText: S.current.date_of_birth_example,
                              enabled: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownMenu<bool>(
                              width: 120,
                              trailingIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              selectedTrailingIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              menuStyle: MenuStyle(
                                backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
                                elevation: MaterialStateProperty.all(0),
                              ),
                              onSelected: (value) {
                                if (value == null) return;
                                _genderValue = value;
                                _gender.text = value ? "Nam" : "Nữ";
                              },
                              inputDecorationTheme: InputDecorationTheme(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              controller: _gender,
                              hintText: S.current.gender,
                              dropdownMenuEntries: const [
                                DropdownMenuEntry<bool>(
                                  value: true,
                                  label: 'Nam',
                                ),
                                DropdownMenuEntry<bool>(
                                  value: false,
                                  label: 'Nữ',
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
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
                            if (_canSignup) {
                              signup();
                            } else {
                              DialogTools.showFailureDialog(context, message: S.current.common_fields_error);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: state is AuthStateLoading
                                ? const RefreshProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  )
                                : Text(S.current.signup),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _name = TextEditingController();
    _dateOfBirth = TextEditingController();
    _gender = TextEditingController();

    _email.addListener(
      () => setState(() {
        _emailErrorText = Validator.email(_email.text);
        checkCanSignup();
      }),
    );
    _password.addListener(
      () => setState(() {
        _passwordErrorText = Validator.password(_password.text, checker: _confirmPassword.text);
        _confirmPasswordErrorText = Validator.password(_confirmPassword.text, checker: _password.text);
        checkCanSignup();
      }),
    );

    _confirmPassword.addListener(
      () => setState(() {
        _confirmPasswordErrorText = Validator.password(_confirmPassword.text, checker: _password.text);
        _passwordErrorText = Validator.password(_password.text, checker: _confirmPassword.text);
        checkCanSignup();
      }),
    );

    _name.addListener(
      () => setState(() {
        _nameErrorText = Validator.name(_name.text);
        checkCanSignup();
      }),
    );

    _dateOfBirth.addListener(() {
      checkCanSignup();
    });

    _gender.addListener(() {
      checkCanSignup();
    });
  }

  void checkCanSignup() {
    _canSignup = _emailErrorText == null && _passwordErrorText == null && _confirmPasswordErrorText == null && _nameErrorText == null && _gender.text.isNotEmpty && _dateOfBirth.text.isNotEmpty;
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _name.dispose();
    _dateOfBirth.dispose();
    _gender.dispose();
    super.dispose();
  }

  void signup() {
    context.read<AuthBloc>().add(
          AuthEventRegister(
            account: Account(
              email: _email.text,
              password: _password.text,
            ),
            profile: Profile(
              name: _name.text,
              gender: _genderValue!,
              birthDate: _dateOfBirth.text,
              email: _email.text,
            ),
          ),
        );
  }

  void pickADate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        DateFormat formatter = DateFormat('dd/MM/yyyy');
        _dateOfBirth.text = formatter.format(value);
      }
    });
  }
}
