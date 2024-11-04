import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/core/routing/route_generator.dart';
import 'package:notesapp/presentation/screens/edit%20note/controller/edit_note_cubit.dart';
import 'package:notesapp/presentation/screens/edit%20note/controller/edit_note_state.dart';
import 'package:notesapp/presentation/screens/note_detail/controller/detail_note_state.dart';
import 'package:notesapp/presentation/screens/note_detail/controller/detial_note_cubit.dart';

class DetailNoteScreen extends StatelessWidget {
  DetailNoteScreen({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool update = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        BlocBuilder<DetailNoteCubit, DetailNoteSate>(builder: (context, state) {
      if (update) {
        titleController.text = state.note.title;
        descriptionController.text = state.note.description;
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("Note Detail"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("Title: "),
                  Text(state.note.title),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("Description: "),
                  Text(state.note.description),
                ],
              )
            ],
          ),
        ),
      );
    }));
  }
}
