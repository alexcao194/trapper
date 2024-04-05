import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trapper/app/presentation/screen/home/home_tabs/widget/custom_chip.dart';
import 'package:trapper/generated/assets.dart';
import '../../../bloc/profile/profile_bloc.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var avatarSize = 140.0;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        var profile = state.profile;
        var sample = [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNFnETCX9oembGfgVxcK805MANhuWInmm-5fjF0jVWv0okup6GjymCho9ew8kjTs5MKtE&usqp=CAU',
          'https://scontent.fhan2-4.fna.fbcdn.net/v/t39.30808-6/435490017_967516594736124_3610444451813777342_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeHFX_Vu1CKJOq1_8OVq2KbqdNolqpyr8LB02iWqnKvwsIgpGyBexytbghAYs5_0fcJo8XtqNbjT5wNSafAEUHxt&_nc_ohc=xmNx_-WMWKoAb4sBis_&_nc_ht=scontent.fhan2-4.fna&oh=00_AfDburOGaZ053YWUyshXpPl5XE9uoYTNu8yoTZIofkVsOA&oe=661608A1',
          'https://scontent.fhan20-1.fna.fbcdn.net/v/t39.30808-6/310229672_129110423217100_2837272561053633667_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGB3OydYXaedTmLmRajZaNyTmwVaH1VBPhObBVofVUE-PiMrAdONqz7XVd7O_KJa9mQu-t59DV8wPQ0x1K3f8EY&_nc_ohc=0BzQfwlvprwAb7XD9kh&_nc_ht=scontent.fhan20-1.fna&oh=00_AfBUM1ZInNLlTNxPvJc7_7ZV9iK448rhBrcdkV7kMNhwVg&oe=6615E74C',
          'https://scontent.fhan2-4.fna.fbcdn.net/v/t39.30808-6/433238832_964022435085540_4242489172994292706_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGEj-W4d5q4CKeJSCrB9dlJzJmZ_Y0XTazMmZn9jRdNrCUti2XpuwCeoILrsJGIs5wjk3FYKPYduGVU7zPhmKIQ&_nc_ohc=Vg7nGJT1ZUUAb5i_QbQ&_nc_ht=scontent.fhan2-4.fna&oh=00_AfBiwmNy-0hTqqviSZmmoLkTAN-S-LNGCXP2XoZNJZDrmw&oe=6615FD28',
          'https://scontent.fhan2-4.fna.fbcdn.net/v/t39.30808-6/434648327_967029688118148_2617184720331156552_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeFoKjRIBXlE0A8gXmzkzRjSQFSEtGywVctAVIS0bLBVy2v58oYvv49uLr9-KweUGF_GIgm4c75OjBQo8lLBMi-I&_nc_ohc=-Va0FMfokxIAb6nZJyV&_nc_ht=scontent.fhan2-4.fna&oh=00_AfBn0eJoMPdLYfm9ju42Z71JgNkDfqdMTrWqVS2jb7x4zg&oe=6616088B',
          'https://scontent.fhan2-4.fna.fbcdn.net/v/t39.30808-6/433238832_964022435085540_4242489172994292706_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGEj-W4d5q4CKeJSCrB9dlJzJmZ_Y0XTazMmZn9jRdNrCUti2XpuwCeoILrsJGIs5wjk3FYKPYduGVU7zPhmKIQ&_nc_ohc=Vg7nGJT1ZUUAb5i_QbQ&_nc_ht=scontent.fhan2-4.fna&oh=00_AfBiwmNy-0hTqqviSZmmoLkTAN-S-LNGCXP2XoZNJZDrmw&oe=6615FD28'
        ];
        return Center(
          child: Stack(
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
                          profile.name ?? "user",
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
                                text: profile.gender != null ? (profile.gender! ? "Male" : "Female") : "Gender",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '19',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 10),
                        const Wrap(
                          children: [
                            CustomChip(label: "Reading", isSelected: true),
                            CustomChip(label: "Music", isSelected: true),
                            CustomChip(label: "Travel", isSelected: true),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text("I only see my goals, I don't believe in failure", style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: 6,
                                // image
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).colorScheme.secondaryContainer,
                                        width: 5,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: index != 5
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(sample[index], fit: BoxFit.cover),
                                          )
                                        : Icon(
                                            Icons.add,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                  );
                                }),
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
      },
    );
  }
}
