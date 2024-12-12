import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/page/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/note_material/coffee_model.dart';
import 'package:first_app/page/coffee_note.dart';
import 'package:first_app/note_material/bottom_nav.dart';
class Coffee extends StatefulWidget {
  const Coffee({super.key});

  @override
  State<Coffee> createState() => _CoffeeState();
}

class _CoffeeState extends State<Coffee> {
  final CollectionReference myNotes = FirebaseFirestore.instance.collection('notes');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.brown,

        title: const Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white
          ),
        ),
      ),

      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: myNotes.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final notes = snapshot.data!.docs;
                List<NoteCard> noteCards = [];
                for (var note in notes) {
                  var data = note.data() as Map<String, dynamic>?;
                  if (data != null) {
                    Note noteObject = Note(
                      id: note.id,
                      title: data['title'] ?? "",
                      note: data['note'] ?? "",
                      country: data['country'],
                      createdAt: data.containsKey('createdAt')
                          ? (data['createdAt'] as Timestamp).toDate()
                          : DateTime.now(),
                      updatedAt: data.containsKey('updatedAt')
                          ? (data['updatedAt'] as Timestamp).toDate()
                          : DateTime.now(),
                      color: data.containsKey('color')
                          ? data['color']
                          : 0xFFFFFFFF,
                    );
                    noteCards.add(
                      NoteCard(
                        note: noteObject,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Screen(note: noteObject),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: noteCards.length,
                  itemBuilder: (context, index) {
                    return noteCards[index];
                  },
                  padding: const EdgeInsets.all(3),
                );
              })
        ],
      ),

      //button
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => Screen(
      //           note: Note(
      //             id: '',
      //             title: '',
      //             note: '',
      //             createdAt: DateTime.now(),
      //             updatedAt: DateTime.now(),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      //   backgroundColor: Colors.blue,
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),

    );

  }
}