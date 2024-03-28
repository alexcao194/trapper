import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/bloc/settings/settings_bloc.dart';
import 'package:trapper/config/const/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),
              Text("Main color:"),
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
                      value: state.redColor.toDouble(),
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
                      value: state.greenColor.toDouble(),
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
                      value: state.blueColor.toDouble(),
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(SettingsChangeBlueColor(value.toInt()));
                      },
                    ),
                  )
                ],
              ),
              Wrap(
                  children: List.generate(AppColors.seeks.length + 1, (index) {
                var color = Color.fromARGB(255, state.redColor, state.greenColor, state.blueColor);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterChip(
                    label: const Text(''),
                    selected: state.themeIndex == index,
                    onSelected: (bool selected) {
                      context.read<SettingsBloc>().add(SettingsChangeTheme(index));
                    },
                    selectedColor: index == 0 ? color : AppColors.seeks[index - 1],
                    backgroundColor: index == 0 ? color : AppColors.seeks[index - 1],
                  ),
                );
              })),
              const SizedBox(height: 20),
              const Text("Language:"),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                      label: const Text('English'),
                      selected: state.languageCode == 'en',
                      onSelected: (bool selected) {
                        context.read<SettingsBloc>().add(const SettingsChangeLanguage('en'));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                      label: const Text('Vietnamese'),
                      selected: state.languageCode == 'vi',
                      onSelected: (bool selected) {
                        context.read<SettingsBloc>().add(const SettingsChangeLanguage('vi'));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FilledButton(
                  onPressed: () {
                    context.read<SettingsBloc>().add(const SettingsSave());
                  },
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  ))
            ],
          );
        },
      ),
    );
  }
}
