
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/info.dart';
import 'package:whatsapp_clone/widgets/chat_list.dart';
import 'package:whatsapp_clone/widgets/contacts_list.dart';
import 'package:whatsapp_clone/widgets/web_chat_appbar.dart';
import 'package:whatsapp_clone/widgets/web_profile_bar.dart';
import 'package:whatsapp_clone/widgets/web_search_bar.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WebProfileBar(
                    profilePicUrl: info[0]['profilePic']!,
                  ),
                  const WebSearchBar(),
                  const ContactsList(),
                ],
              ),
            ),
          ),
          // Web Screen

          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/backgroundImage.png'),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                WebChatAppbar(
                    profilePicUrl: info[0]['profilePic']!,
                    userName: info[0]['name']!),
                const Expanded(child: ChatList()),
                Container(
                  height: MediaQuery.of(context).size.height * 0.077,
                  decoration: const BoxDecoration(
                    color: chatBarMessage
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.emoji_emotions_outlined ,color: appBarTextColor,)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.attach_file, color: appBarTextColor,)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: searchBarColor,
                              hintText: 'Type a Message',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none
                                )
                              ),
                              contentPadding: const EdgeInsets.only(left: 20)
                            ),
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.mic, color: appBarTextColor,))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
