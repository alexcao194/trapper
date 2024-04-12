import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trapper/config/message_distribution/message_distribution.dart';

import '../../../../../generated/l10n.dart';
import '../../../bloc/connect/connect_bloc.dart';
import 'widget/custom_chip.dart';

List<String> genders = <String>[S.current.male, S.current.female];

class ConnectTab extends StatelessWidget {
  const ConnectTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectBloc, ConnectState>(
      builder: (context, state) {
        final connectData = state.connectData;
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  S.current.search_prompt,
                  style: const TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Text(S.current.age),
                    const Spacer(),
                    Text('${connectData.minAge} - ${connectData.maxAge}'),
                  ],
                ),
                RangeSlider(
                  min: 16,
                  max: 100,
                  values: RangeValues(
                    connectData.minAge.toDouble(),
                    connectData.maxAge.toDouble(),
                  ),
                  onChanged: (values) {
                    context.read<ConnectBloc>().add(ConnectUpdateData(
                          connectData: connectData.copyWith(
                            minAge: values.start.toInt(),
                            maxAge: values.end.toInt(),
                          ),
                        ));
                  },
                ),
                const SizedBox(height: 20),
                Text(S.current.gender),
                Wrap(
                  children: List.generate(genders.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomChip(
                        isSelected: connectData.gender == index,
                        label: genders[index],
                        onSelected: (bool selected) {
                          context.read<ConnectBloc>().add(
                                ConnectUpdateData(
                                  connectData: connectData.copyWith(
                                    gender: selected ? index : 0,
                                  ),
                                ),
                              );
                        },
                      ),
                    );
                  }),
                ),
                Text(S.current.hobbies),
                Wrap(
                  children: List.generate(state.hobbies.length, (index) {
                    final hobby = state.hobbies[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomChip(
                        isSelected: connectData.hobbies.contains(index),
                        label: MessageDistribution.fromID(hobby.id),
                        onSelected: (bool selected) {
                          if (selected && connectData.hobbies.length >= 3) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(S.current.hobbies_limit),
                              ),
                            );
                            return;
                          }
                          context.read<ConnectBloc>().add(
                                ConnectUpdateData(
                                  connectData: connectData.copyWith(
                                    hobbies: selected
                                        ? [...connectData.hobbies, index]
                                        : connectData.hobbies.where((e) => e != index).toList(),
                                  ),
                                ),
                              );
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.search),
                            Text(S.current.search),
                          ],
                        ),
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
}
