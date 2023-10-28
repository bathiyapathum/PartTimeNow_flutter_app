import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class NotCard extends StatefulWidget {
  const NotCard({super.key, required this.NotificationType});
  final String NotificationType;

  @override
  State<NotCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 7,
      ),
      elevation: 15,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 10, right: 7, top: 10, bottom: 10),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: navActivaeColor,
                  radius: 22,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3HWiMNcayzEoGFI70CWs-4GRnFFMgIcR4Ig&usqp=CAU'),
                    // fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Text(
                      'Dilshan Perera',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              alignment: Alignment.topCenter,
              child: const Text(
                ' agoLorum Last long time agoLorum Last long time ago ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          widget.NotificationType == 'request' ?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.only(
                        left: 45, top: 10, bottom: 10, right: 45),
                    child: const Center(
                      child: Text(
                        'Reject',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.only(
                        left: 45, top: 10, bottom: 10, right: 45),
                    child: const Center(
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ) : Container(),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
