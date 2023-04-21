import 'package:feathersjs_demo_app/models/user.dart';
import 'package:flutter/material.dart';

class ReceiverMessageTile extends StatelessWidget {
  const ReceiverMessageTile({Key? key, required this.content}) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          backgroundImage: NetworkImage(User.profileImages.last),
        ),
      ),
      title: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      trailing: const SizedBox(width: 50),
      subtitle: const Padding(
        padding: EdgeInsets.only(left: 8, top: 4),
        child: Text('8:04 AM', style: TextStyle(fontSize: 10)),
      ),
    );
  }
}

class SenderMessageTile extends StatelessWidget {
  const SenderMessageTile({Key? key, required this.content}) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const SizedBox(width: 50),
      visualDensity: VisualDensity.comfortable,
      title: Wrap(alignment: WrapAlignment.end, children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            content,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white),
            softWrap: true,
          ),
        ),
      ]),
      subtitle: const Padding(
        padding: EdgeInsets.only(right: 8, top: 4),
        child: Text(
          '10:03 AM',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 10),
        ),
      ),
      trailing: CircleAvatar(
        backgroundImage: NetworkImage(User.profileImages.first),
      ),
    );
  }
}
