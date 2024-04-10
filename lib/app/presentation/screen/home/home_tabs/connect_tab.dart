import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/connect/connect_bloc.dart';
import 'widget/custom_chip.dart';

List<String> genders = <String>['Nam', 'Nữ', 'Tất cả'];

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
                  min: 18,
                  max: 50,
                  values: RangeValues(
                    connectData.minAge.toDouble(),
                    connectData.maxAge.toDouble(),
                  ),
                  onChanged: (values) {},
                ),
                const SizedBox(height: 20),
                const Text('Giới tính: '),
                Wrap(
                  children: genders
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomChip(
                              label: e,
                              isSelected: true,
                              onSelected: (bool selected) {},
                            ),
                          ))
                      .toList(),
                ),
                const Text('Sở thatch: '),
                Wrap(
                  children: connectData.hobbies.map((hobby) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomChip(
                        label: hobby.toString(),
                        isSelected: false,
                        onSelected: (bool selected) {},
                      ),
                    );
                  }).toList(),
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
