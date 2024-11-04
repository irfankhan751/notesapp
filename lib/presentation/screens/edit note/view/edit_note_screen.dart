import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/core/routing/route_generator.dart';
import 'package:notesapp/presentation/screens/edit%20note/controller/edit_note_cubit.dart';
import 'package:notesapp/presentation/screens/edit%20note/controller/edit_note_state.dart';

class EditNoteScreen extends StatelessWidget {
  EditNoteScreen({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool update = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        BlocBuilder<EditNoteCubit, EditNoteSate>(builder: (context, state) {
      if (update) {
        titleController.text = state.note.title;
        descriptionController.text = state.note.description;
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("Edit Note"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                        if (await context.read<EditNoteCubit>().createNote(
                            titleController.text, descriptionController.text)) {
                          Fluttertoast.showToast(
                              msg: "Note Updated Successfully");
                          Navigator.pushReplacementNamed(
                              context, RouteGenerator.mainPage);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error while saving note");
                        }
                      },
                      child: Text("Save Changes"),
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
