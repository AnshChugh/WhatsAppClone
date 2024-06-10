import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';

class WebProfileBar extends StatelessWidget {
  final String profilePicUrl;
  const WebProfileBar({super.key, required this.profilePicUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.077,
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: const BoxDecoration(color: appBarColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
                          backgroundImage: NetworkImage(profilePicUrl),
                        ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment,
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
