import 'package:flutter/material.dart';
import 'package:blog_aplication_flutter/ui/views/home/home_view.dart';
import 'package:blog_aplication_flutter/ui/views/home/add_blog.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String currentScreen;

  const CustomBottomNavBar({Key? key, required this.currentScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (currentScreen != 'home') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              }
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, color: Colors.white),
                Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentScreen != 'add_blog') {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const AddBlog()),
                );
              }
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, color: Colors.white),
                Text(
                  'Add Blog',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              _showPopupMenu(context, details.globalPosition);
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.settings, color: Colors.white),
                Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPopupMenu(BuildContext context, Offset offset) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        const PopupMenuItem<String>(
          value: 'Profile',
          child: Text('Profile'),
        ),
        const PopupMenuItem<String>(
          value: 'Logout',
          child: Text('Logout'),
        ),
      ],
    ).then((String? value) {
      if (value == 'Profile') {
        // Navigate to profile screen
      } else if (value == 'Logout') {
        // Perform logout action
      }
    });
  }
}
