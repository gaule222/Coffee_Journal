import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:first_app/page/detail_screen.dart';

import 'package:first_app/note_material/coffee_model.dart';


class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  GNav(
      color:  Colors.grey[700],
      mainAxisAlignment: MainAxisAlignment.center,

      tabBackgroundColor: Colors.grey.shade300,
      tabBorderRadius: 24,
      tabActiveBorder: Border.all(color: Colors.white),
      tabs: [

        GButton(icon: Icons.add,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Screen(
                  note: Note(
                    id: '',
                    title: '',
                    note: '',
                    country: '',
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                ),
              ),
            );
          },

        ),

    ],

    );
  }
}
