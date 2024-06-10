import 'package:flutter/material.dart';
import 'package:whatsapp_clone/theme/colors.dart';
import 'package:whatsapp_clone/info.dart';
import 'package:whatsapp_clone/widgets/chat_list.dart';

class MobileChatScreen extends StatelessWidget {
  const MobileChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          info[0]['name'].toString(),
          style: const TextStyle(
              color: appBarTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.video_call,
                color: appBarTextColor,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call,
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
      body: Column(
        children: [
          const Expanded(child: ChatList()),
          TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: mobileChatBoxColor,
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.emoji_emotions, color: appBarTextColor),
                ),
                suffixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: appBarTextColor,
                      ),
                      Icon(
                        Icons.attach_file,
                        color: appBarTextColor,
                      ),
                      Icon(
                        Icons.money,
                        color: appBarTextColor,
                      ),
                    ],
                  ),
                ),
                hintText: 'Type a Message!',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
                contentPadding: const EdgeInsets.all(8)),
          )
        ],
      ),
    );
  }
}
