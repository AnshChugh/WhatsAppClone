import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';

class WebSearchBar extends StatelessWidget {
  const WebSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.077,
        width: MediaQuery.of(context).size.width * 0.25,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: dividerColor))),
        child: TextField(
          
          decoration: InputDecoration(
              filled: true,
              fillColor: searchBarColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.search, size: 20,),
              prefixIconColor: appBarTextColor,
              hintStyle: const TextStyle(fontSize: 14),
              hintText: 'Search or start a new chat'),
        ));
  }
}
