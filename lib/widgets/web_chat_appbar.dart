import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';

class WebChatAppbar extends StatelessWidget {
  final String profilePicUrl;
  final String userName;
  const WebChatAppbar({super.key, required this.profilePicUrl , required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.077,
      decoration: const BoxDecoration(color: appBarColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profilePicUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(userName),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: appBarTextColor,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: appBarTextColor,
                )),
          ],
        ),
      ),
    );
  }
}
