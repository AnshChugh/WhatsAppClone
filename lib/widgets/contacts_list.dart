import 'package:flutter/material.dart';
import 'package:whatsapp_clone/theme/colors.dart';
import 'package:whatsapp_clone/info.dart';
import 'package:whatsapp_clone/screens/mobile_chat_screen.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: info.length,
        itemBuilder: (context, index) {
          return Column(children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MobileChatScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(info[index]['profilePic']!),
                  ),
                  title: Text(
                    info[index]['name']!,
                    style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      info[index]['message']!,
                      style:
                          const TextStyle(color: appBarTextColor, fontSize: 15),
                    ),
                  ),
                  trailing: Text(
                    info[index]['time'].toString(),
                    style:
                        const TextStyle(color: appBarTextColor, fontSize: 13),
                  ),
                ),
              ),
            ),
            const Divider(
              color: dividerColor,
              indent: 85,
            )
          ]);
        },
      ),
    );
  }
}
