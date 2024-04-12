import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trapper/app/presentation/bloc/settings/settings_bloc.dart';
import 'package:trapper/app/presentation/screen/login/widget/rounded_text_field.dart';
import 'package:trapper/config/const/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trapper/config/const/dimen.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../generated/assets.dart';
import '../../../../domain/entity/profile.dart';
import '../../../bloc/profile/profile_bloc.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late TextEditingController _nameController;
  late TextEditingController _birthDateController;
  late TextEditingController _bioController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, profileState) {
          if (profileState.sendMessage) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(profileState.message!),
              duration: const Duration(seconds: 2),
            ));
          }
        },
        builder: (context, profileState) {
          var profile = profileState.profile;
          return BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settingsState) {
              final colorDashboard = <Widget>[
                const Text("Main color:"),
                Row(
                  children: [
                    const Expanded(flex: 1, child: Text('Red')),
                    Expanded(
                      flex: 9,
                      child: Slider(
                        activeColor: Colors.red,
                        inactiveColor: Colors.red[100],
                        secondaryActiveColor: Colors.red[200],
                        thumbColor: Colors.red[300],
                        min: 0,
                        max: 255,
                        value: settingsState.redColor.toDouble(),
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(SettingsChangeRedColor(value.toInt()));
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Expanded(flex: 1, child: Text('Green')),
                    Expanded(
                      flex: 9,
                      child: Slider(
                        activeColor: Colors.green,
                        inactiveColor: Colors.green[100],
                        secondaryActiveColor: Colors.green[200],
                        thumbColor: Colors.green[300],
                        min: 0,
                        max: 255,
                        value: settingsState.greenColor.toDouble(),
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(SettingsChangeGreenColor(value.toInt()));
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Expanded(flex: 1, child: Text('Blue')),
                    Expanded(
                      flex: 9,
                      child: Slider(
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue[100],
                        secondaryActiveColor: Colors.blue[200],
                        thumbColor: Colors.blue[300],
                        min: 0,
                        max: 255,
                        value: settingsState.blueColor.toDouble(),
                        onChanged: (value) {
                          context.read<SettingsBloc>().add(SettingsChangeBlueColor(value.toInt()));
                        },
                      ),
                    )
                  ],
                ),
                Wrap(
                    children: List.generate(AppColors.seeks.length + 1, (index) {
                  var color = Color.fromARGB(255, settingsState.redColor, settingsState.greenColor, settingsState.blueColor);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                      label: const Text(''),
                      selected: settingsState.themeIndex == index,
                      onSelected: (bool selected) {
                        context.read<SettingsBloc>().add(SettingsChangeTheme(index));
                      },
                      selectedColor: index == 0 ? color : AppColors.seeks[index - 1],
                      backgroundColor: index == 0 ? color : AppColors.seeks[index - 1],
                    ),
                  );
                })),
              ];

              var saveButton = FilledButton(
                  onPressed: () {
                    _save();
                  },
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  ));
              var updateButton = FilledButton(
                  onPressed: profileState.isLoading ? null : _update,
                  child: Text(
                    'Update',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  ));

              final languageSettings = <Widget>[
                const Text("Language:"),
                Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: const Text('English'),
                        selected: settingsState.languageCode == 'en',
                        onSelected: (bool selected) {
                          context.read<SettingsBloc>().add(const SettingsChangeLanguage('en'));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: const Text('Vietnamese'),
                        selected: settingsState.languageCode == 'vi',
                        onSelected: (bool selected) {
                          context.read<SettingsBloc>().add(const SettingsChangeLanguage('vi'));
                        },
                      ),
                    ),
                  ],
                ),
              ];
              final avatar = GestureDetector(
                onTap: _showImagePicker,
                child: Center(
                  child:                         Container(
                    height: 140,
                    width: 140,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            width: 5,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: profile.photoUrl != null
                              ? Image.network(
                            profile.photoUrl!,
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                            Assets.pngDefaultAvatar,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                ),
              );

              final fields = <Widget>[
                RoundedTextField(
                  hintText: profile.name ?? "user",
                  label: "Name",
                  controller: _nameController,
                ),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        DateFormat formatter = DateFormat('dd/MM/yyyy');
                        _birthDateController.text = formatter.format(value);
                      }
                    });
                  },
                  child: RoundedTextField(
                    hintText: profile.birthDate ?? "birthday",
                    label: "Birthday",
                    controller: _birthDateController,
                    enabled: false,
                  ),
                ),
                RoundedTextField(
                  hintText: profile.bio ?? "",
                  label: "Bio",
                  controller: _bioController,
                ),
              ];
              var size = MediaQuery.of(context).size;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                    ),
                    if (size.width > Dimen.mobileWidth)
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                avatar,
                                const SizedBox(height: 20),
                                ...fields,
                                const SizedBox(height: 20),
                                updateButton,
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ...colorDashboard,
                                const SizedBox(height: 20),
                                ...languageSettings,
                                const SizedBox(height: 20),
                                saveButton,
                              ],
                            ),
                          ),
                        ],
                      )
                    else ...[
                      avatar,
                      const SizedBox(height: 20),
                      ...fields,
                      const SizedBox(height: 20),
                      updateButton,
                      const SizedBox(height: 20),
                      ...colorDashboard,
                      const SizedBox(height: 20),
                      ...languageSettings,
                      const SizedBox(height: 20),
                      saveButton,
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _birthDateController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _showImagePicker() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
      if (value == null) return;

      context.read<ProfileBloc>().add(
            ProfileEventUpdate(
              Profile(
                name: _nameController.text,
                birthDate: _birthDateController.text,
              ),
              image: await value.readAsBytes(),
            ),
          );
    });
  }

  _update() {
    context.read<ProfileBloc>().add(
          ProfileEventUpdate(
            Profile(
              name: _nameController.text,
              birthDate: _birthDateController.text,
              bio: _bioController.text,
            ),
          ),
        );
  }

  void _save() {
    context.read<SettingsBloc>().add(const SettingsSave());
  }
}
