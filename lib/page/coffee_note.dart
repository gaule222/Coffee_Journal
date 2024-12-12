import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:first_app/note_material/coffee_model.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onPressed;
  const NoteCard({super.key, required this.note, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // for date and time
    DateTime displayTime = note.updatedAt.isAfter(note.createdAt)
        ? note.updatedAt
        : note.createdAt;
    // display format
    String formattedDateTime =
    DateFormat('h:mma MMMM d, y').format(displayTime);
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Color(note.color),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('name',),
              Text(
                note.title,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(

                children: [
                  Container(),
                  const Spacer(),
                  Text(
                    formattedDateTime,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Country of Origin'),
                  Text(
                    note.country ,
                    maxLines: 4,
                    style: const TextStyle(
                      fontSize: 17,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('Repcipes'),
                Text(
                  note.note,
                  maxLines: 4,
                  style: const TextStyle(
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],),
            ],
          ),
        ),
      ),
    );
  }
}