import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/header_message.dart';
import 'package:trapper/app/presentation/widget/message_item.dart';
import 'package:trapper/app/presentation/widget/search_message.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            color: Colors.black26,
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Column(
              children: [
                HeaderMessage(),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 8 * 7 ,
                  padding: const EdgeInsets.fromLTRB(0, 15, 5, 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SearchMessage(),
                      SizedBox(height: 15),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) { return MessageItem();},
                        ),
                      ),
                    ]
                  ),
                ),
              ],
            )
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3 * 2,
            color: Colors.black,

          )
        ],
      )
    );
  }
}
