import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/routing/route_generator.dart';
import 'package:notesapp/data/model/notes_model.dart';
import 'package:notesapp/presentation/screens/main%20screen/controller/main_screen_cubit.dart';
import 'package:notesapp/presentation/screens/main%20screen/controller/main_screen_state.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        BlocBuilder<MainScreenCubit, MainScreenSate>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Notes"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, RouteGenerator.initialPage);
              },
            ),
          ],
        ),
        body: StreamBuilder<List<Note>>(
          stream: context.read<MainScreenCubit>().fetchUserNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child:
                      Text(snapshot.error.toString() + "Failed to load notes"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No notes found"));
            }

            final notes = snapshot.data!;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteGenerator.detailPage,
                        arguments: {'note': note});
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(note.title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteGenerator.editNotesPage,
                                  arguments: {'note': note});
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _showDeleteDialog(context, index, () {
                                context
                                    .read<MainScreenCubit>()
                                    .deleteNote(note);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteGenerator.newNotesPage);
          },
          child: Icon(Icons.add),
        ),
      );
    }));
  }

  void _showDeleteDialog(BuildContext context, int index, Function onYes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Note"),
          content: Text("Are you sure you want to delete this note?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onYes();
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
