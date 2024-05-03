import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../domain/entity/profile.dart';
import '../../../bloc/profile/profile_bloc.dart';
import 'widget/custom_chip.dart';

class ProfileTab extends StatelessWidget {
  final Profile profile;
  final bool owner;

  const ProfileTab({super.key, required this.profile, this.owner = true});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var avatarSize = 140.0;
    final photos = profile.photos ?? [];
    int age = 0;
    if (profile.birthDate != null) {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      DateTime date = dateFormat.parse(profile.birthDate!);
      age = DateTime.now().year - date.year;
    }
    return Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: double.infinity,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
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
                    const SizedBox(height: 10),
                    Text(profile.bio ?? "", style: TextStyle(color: Theme.of(context).colorScheme.onSurface), textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: photos.length,
                          // image
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: owner ? () {
                                _pickImage(context, index);
                              } : null,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.secondaryContainer,
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: photos[index] != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(photos[index]!, fit: BoxFit.cover),
                                      )
                                    : Icon(
                                        Icons.add,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pickImage(BuildContext context, int index) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
      if (value == null) return;

      context.read<ProfileBloc>().add(ProfileEventPostPhoto(
            image: await value.readAsBytes(),
            index: index,
          ));
    });
  }
}
