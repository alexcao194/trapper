import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/avatar_message.dart';

class HeaderMessage extends StatelessWidget {
  const HeaderMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 9,
      width: MediaQuery.of(context).size.width,
      //color: Colors.black12,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 10 * 2,
            height: MediaQuery.of(context).size.height / 10 ,
            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5), // top, left, bottom, right
            child: ListTile(
              leading: AvatarMessage(),
              title: Text("Annona", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("@lna17", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54)),
              onTap: () {
                //context.go(RoutePath.messages);
              },
            ),
          ),
          Expanded(child: SizedBox()),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined, size: 30),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
