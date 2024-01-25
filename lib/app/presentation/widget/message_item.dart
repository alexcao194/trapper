import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/avatar_message.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width / 3 ,
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      //color: Colors.black26,
      child: Center(
        child: ListTile(
          leading: AvatarMessage(),
          trailing: Text("Date", style: TextStyle(color: Colors.black54)),
          title: Text("User Name", style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Latest Message", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54)),
          onTap: () {},
        ),
      ),
    );
  }
}
