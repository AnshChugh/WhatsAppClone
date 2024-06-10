import 'package:flutter/material.dart';
import 'package:whatsapp_clone/theme/colors.dart';
import 'package:whatsapp_clone/widgets/contacts_list.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            title: const Text(
              'WhatsApp',
              style: TextStyle(
                  color: appBarTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: appBarColor,
            actions: [
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
            bottom: const TabBar(
                indicatorColor: tabColor,
                labelColor: tabColor,
                unselectedLabelColor: appBarTextColor,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: tabColor, width: 3)),
                tabs: [
                  Tab(
                    text: 'CHATS',
                  ),
                  Tab(
                    text: 'STATUS',
                  ),
                  Tab(
                    text: 'CALLS',
                  ),
                ]),
          ),
          body: const ContactsList(),
          floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: tabColor,
              child: const Icon(
                Icons.comment,
                color: textColor,
              )),
        ));
  }
}
