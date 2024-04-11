import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/connect/connect_bloc.dart';
import 'widget/custom_chip.dart';

List<String> genders = <String>['Nam', 'Nữ'];

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
                const Text(
                  'Bạn muốn tìm người như thế nào?',
                  style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    const Text('Tuổi: '),
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
                const Text('Giới tính: '),
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
                const Text('Sở thatch: '),
                Wrap(
                  children: List.generate(state.hobbies.length, (index) {
                    final hobby = state.hobbies[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomChip(
                        isSelected: connectData.hobbies.contains(index),
                        label: hobby.name,
                        onSelected: (bool selected) {
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            Text('Tìm kiếm'),
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
