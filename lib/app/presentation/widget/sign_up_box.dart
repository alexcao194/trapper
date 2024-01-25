import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trapper/app/domain/entity/account.dart';
import 'package:trapper/app/domain/entity/profile.dart';
import 'package:trapper/utils/dialog_tools.dart';
import 'package:intl/intl.dart';

import '../../../utils/validator.dart';
import '../bloc/auth/auth_bloc.dart';
import '../../../generated/l10n.dart';
import 'form_text_field.dart';

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

  bool canSignup = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          FormTextField(
            controller: _email,
            hintText: S.current.email_example,
            labelText: S.current.email,
            errorText: _emailErrorText,
          ),
          Row(
            children: [
              Expanded(
                child: FormTextField(
                  controller: _password,
                  hintText: S.current.password_example,
                  labelText: S.current.password,
                  errorText: _passwordErrorText,
                  obscureText: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FormTextField(
                  controller: _confirmPassword,
                  hintText: S.current.confirm_password_example,
                  labelText: S.current.confirm_password,
                  errorText: _confirmPasswordErrorText,
                  obscureText: true,
                ),
              ),
            ],
          ),
          FormTextField(
            controller: _name,
            hintText: S.current.full_name_example,
            labelText: S.current.full_name,
            errorText: _nameErrorText,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: pickADate,
                  child: FormTextField(
                    controller: _dateOfBirth,
                    hintText: S.current.date_of_birth_example,
                    labelText: S.current.date_of_birth,
                    enabled: false,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              DropdownMenu(
                label: Text(S.current.gender),
                controller: _gender,
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: true, label: S.current.male),
                  DropdownMenuEntry(value: false, label: S.current.female),
                ],
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
                  if (canSignup) {
                    signup();
                    Navigator.of(context).pop();
                  } else {
                    DialogTools.showFailureDialog(context, message: S.current.common_fields_error);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(S.current.signup),
                ),
              ),
            ],
          )
        ],
      ),
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
    _dateOfBirth.text = "01/01/1999";
    _gender = TextEditingController();

    _email.addListener(
      () => setState(() {
        _emailErrorText = Validator.email(_email.text);
        checkCanSignup();
      }),
    );
    _password.addListener(
      () => setState(() {
        _passwordErrorText = Validator.password(_password.text);
        checkCanSignup();
      }),
    );

    _confirmPassword.addListener(
      () => setState(() {
        _confirmPasswordErrorText = Validator.confirmPassword(_confirmPassword.text, _password.text);
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
    canSignup = _emailErrorText == null && _passwordErrorText == null && _confirmPasswordErrorText == null && _nameErrorText == null && _gender.text.isNotEmpty && _dateOfBirth.text.isNotEmpty;
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
              gender: _gender.text == S.current.male,
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
