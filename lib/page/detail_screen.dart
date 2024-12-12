import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:first_app/note_material/coffee_model.dart';

class Screen extends StatefulWidget {
  final Note note;

  const Screen({super.key, required this.note});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

  final CollectionReference myNotes = FirebaseFirestore.instance.collection('notes');
  late TextEditingController titleController ;
  late TextEditingController noteController ;
  late TextEditingController countryController;
  late Note note = widget.note;
  String titleString='';
  String noteString= '';
  String countryString ='';
  late int color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    note = widget.note;
    titleString=note.title;
    countryString=note.country;
    noteString=note.note;
    color = note.color == 0xFFFFFFFF ? generateRandomLightColor() :note.color;
    titleController = TextEditingController(text: titleString);
    noteController = TextEditingController(text: noteString);
    countryController = TextEditingController(text: countryString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(20),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.grey ,),
          child:  const BackButton(color: Colors.white,),
        ),
            Text(note.id.isEmpty ?'New Product': 'Edit Product', style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.grey ,),
            child:  Row(
              children: [IconButton(onPressed:(){
                saveNotes();
                Navigator.pop(context);}, icon: const Icon(Icons.save,color: Colors.white,)
              ),
                if(note.id.isNotEmpty)
                  IconButton(onPressed:(){
                    myNotes.doc(note.id).delete();
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.delete,color: Colors.white,))
              ],
            ),
          ),

        ],),
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            border: InputBorder.none,
                hintText:"Name"
          ),
          onChanged: (value){
            titleString=value;
          },
        ),
        TextField(
          controller: countryController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText:"Country Of Origin"
          ),
          onChanged: (value){
            countryString=value;
          },
        ),
          Expanded(
            child: TextField(
              controller: noteController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText:"Recipe Detail"
              ),
              onChanged: (value){
                noteString=value;
              },
            ),

          ),

      ],),
      )),
    );
  }
  void saveNotes() async{
    DateTime now = DateTime.now();
    if(note.id.isEmpty){
      await myNotes.add(
        {
          'title': titleString,
          'note': noteString,
          'country':countryString,
          'color':color,
          'createdAt': now,
        }
      );
    }
    else {
      await
      myNotes.doc(note.id).update({
        'title': titleString,
        'country':countryString,
        'note': noteString,
        'color':color,
        'updatedAt': now,
      });
    }
  }
}
