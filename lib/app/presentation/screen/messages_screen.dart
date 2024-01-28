import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/avatar_message.dart';
import 'package:trapper/app/presentation/widget/detail_header_message.dart';
import 'package:trapper/app/presentation/widget/header_message.dart';
import 'package:trapper/app/presentation/widget/input_message.dart';
import 'package:trapper/app/presentation/widget/message_item.dart';
import 'package:trapper/app/presentation/widget/search_message.dart';
import 'package:trapper/app/presentation/widget/text_message.dart';

import '../../../config/const/dimen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: SizedBox(
              width: size.width > Dimen.mobileWidth ? size.width * 0.42 : 80,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  if (size.width > Dimen.mobileWidth) const HeaderMessage() else const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: AvatarMessage(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: Column(children: [
                          if(size.width > Dimen.mobileWidth) const Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                            child: SearchMessage(),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: size.width > Dimen.mobileWidth ? const MessageItem() : const AvatarMessage()
                                );
                              },
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1000,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  //color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.75),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.onInverseSurface,
                          ),
                          child: const DetailHeaderMessage()
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: const TextMessage()
                            );
                          },
                        ),
                      ),
                      const InputMessage()
                    ],
                  ),
                ),

              ),
            ),
        ],
      ),
    );
  }
}
