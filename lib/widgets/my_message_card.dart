import 'package:flutter/material.dart';
import 'package:whatsapp_clone/theme/colors.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String time;
  const MyMessageCard({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
          child: Card(
            elevation: 1,
            color: messageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 19,
                    top:5,
                    right: 30,
                    bottom: 20
                  ),
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 2,
                  child: Row(
                    children: [
                      Text(
                      time, style: const TextStyle(
                        fontSize: 13,
                        color: appBarTextColor
                      ),
                     ),const SizedBox(width: 5,),
                      const Icon(Icons.done_all, color:appBarTextColor,size: 16,)
                    ],
                  ),
                  ),
              ],
            ),
          ),
        )
        );
  }
}
