import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trapper/app/domain/entity/account.dart';
import 'package:trapper/app/domain/entity/profile.dart';
import 'package:trapper/utils/dialog_tools.dart';
import 'package:intl/intl.dart';

import '../../../utils/validator.dart';
import '../bloc/auth/auth_bloc.dart';
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
            hintText: 'Email',
            labelText: 'Email',
            errorText: _emailErrorText,
          ),
          Row(
            children: [
              Expanded(
                child: FormTextField(
                  controller: _password,
                  hintText: 'Password',
                  labelText: 'Password',
                  errorText: _passwordErrorText,
                  obscureText: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FormTextField(
                  controller: _confirmPassword,
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  errorText: _confirmPasswordErrorText,
                  obscureText: true,
                ),
              ),
            ],
          ),
          FormTextField(
            controller: _name,
            hintText: 'Name',
            labelText: 'Name',
            errorText: _nameErrorText,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: pickADate,
                  child: FormTextField(
                    controller: _dateOfBirth,
                    hintText: 'Date of Birth',
                    labelText: 'Date of Birth',
                    enabled: false,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              DropdownMenu(
                label: const Text("Gender"),
                controller: _gender,
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: true, label: "Male"),
                  DropdownMenuEntry(value: false, label: "Female"),
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
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Cancel'),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (canSignup) {
                    signup();
                    Navigator.of(context).pop();
                  } else {
                    DialogTools.showFailureDialog(context, message: "Please fill all fields with valid data");
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Sign up'),
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
              gender: _gender.text == "Male",
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
