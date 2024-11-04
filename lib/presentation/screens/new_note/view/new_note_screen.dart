import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/core/routing/route_generator.dart';
import 'package:notesapp/presentation/screens/new_note/controller/new_note_cubit.dart';
import 'package:notesapp/presentation/screens/new_note/controller/new_note_state.dart';

class NewNoteScreen extends StatelessWidget {
  NewNoteScreen({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        BlocBuilder<NewNoteCubit, NewNoteSate>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Add Note"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              state.isLoading ?? false
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () async {
                        if (titleController.text.isEmpty ||
                            descriptionController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Fill All Field");
                        } else {
                          if (await context.read<NewNoteCubit>().createNote(
                              titleController.text,
                              descriptionController.text)) {
                            Fluttertoast.showToast(
                                msg: "Note Saved Successfully");
                            Navigator.pushReplacementNamed(
                                context, RouteGenerator.mainPage);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Error while saving note");
                          }
                        }
                      },
                      child: Text("Save"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
            ],
          ),
        ),
      );
    }));
  }
}
