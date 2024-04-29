import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../config/go_router/app_go_router.dart';
import '../../../../../config/message_distribution/message_distribution.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/dialog_tools.dart';
import '../../../bloc/connect/connect_bloc.dart';
import '../../../bloc/profile/profile_bloc.dart';
import 'widget/custom_chip.dart';

class ConnectTab extends StatelessWidget {
  const ConnectTab({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var avatarSize = 140.0;
    return BlocConsumer<ConnectBloc, ConnectState>(
      listener: (context, connectState) {
        if (connectState.showError && connectState.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(connectState.error!),
              duration: const Duration(seconds: 3),
            ),
          );
        }

        if (connectState.roomInfo != null) {
          context.go(RoutePath.messages);
          context.read<ConnectBloc>().add(const ConnectReset());
        }
      },
      builder: (context, connectState) {
        final connectData = connectState.connectData;
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            var profile = profileState.profile;
            int age = 0;
            if (profile.birthDate != null) {
              DateFormat dateFormat = DateFormat("dd/MM/yyyy");
              DateTime date = dateFormat.parse(profile.birthDate!);
              age = DateTime.now().year - date.year;
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            width: double.infinity,
                            height: size.height * 0.2,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            )),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.2 - avatarSize / 2),
                          child: SizedBox(
                            width: size.width < 600 ? size.width : 600,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: avatarSize,
                                  width: avatarSize,
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
                                Text(
                                  profile.name ?? S.current.full_name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(
                                          profile.gender != null ? (profile.gender! ? Icons.male : Icons.female) : Icons.person,
                                          size: 20,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: profile.gender != null ? (profile.gender! ? S.current.male : S.current.female) : S.current.gender,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  age.toString(),
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                    children: List.generate(
                                      profile.hobbies.length,
                                          (index) => CustomChip(
                                        label: profile.hobbies[index].name,
                                        isSelected: true,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: size.width < 600 ? size.width : 920,
                    ),
                    child: Column(
                      children: [
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
                          children: List.generate(2, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomChip(
                                isSelected: connectData.gender == (index == 0),
                                label: index == 0 ? S.current.male : S.current.female,
                                onSelected: (bool selected) {
                                  context.read<ConnectBloc>().add(
                                        ConnectUpdateData(
                                          connectData: connectData.copyWith(
                                            gender: selected && index == 0 ? true : false,
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
                          children: List.generate(connectState.hobbies.length, (index) {
                            final hobby = connectState.hobbies[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomChip(
                                isSelected: connectData.hobbies.contains(hobby.id),
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
                                          connectData: connectData.copyWith(hobbies: selected ? [...connectData.hobbies, hobby.id] : connectData.hobbies.where((element) => element != hobby.id).toList()),
                                        ),
                                      );
                                },
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                              ),
                              onPressed: () {
                                _search(context, connectState);
                              },
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
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _search(BuildContext context, ConnectState connectState) {
    context.read<ConnectBloc>().add(const ConnectFindFriend());
    if (connectState.connectData.hobbies.isEmpty) {
      return;
    }
    DialogTools.showConnectDialog(context, () {
      context.read<ConnectBloc>().add(const ConnectCancelFindFriend());
    });
  }
}
