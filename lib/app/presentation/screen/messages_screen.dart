import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/header_message.dart';
import 'package:trapper/app/presentation/widget/message_item.dart';
import 'package:trapper/app/presentation/widget/search_message.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Expanded(child: HeaderMessage()),
                Expanded(
                  flex: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Column(children: [
                        const SearchMessage(),
                        const SizedBox(height: 15),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: MessageItem(),
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
          Expanded(
            flex: 3,
            child: Container(

            ),
          )
        ],
      ),
    );
  }
}
