import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/core/routing/error_page.dart';
import 'package:notesapp/presentation/screens/authentication/controller/authentication_cubit.dart';
import 'package:notesapp/presentation/screens/authentication/controller/authentication_state.dart';
import 'package:notesapp/presentation/screens/authentication/view/authentication_screen.dart';
import 'package:notesapp/presentation/screens/edit%20note/controller/edit_note_cubit.dart';
import 'package:notesapp/presentation/screens/edit%20note/view/edit_note_screen.dart';
import 'package:notesapp/presentation/screens/main%20screen/controller/main_screen_cubit.dart';
import 'package:notesapp/presentation/screens/main%20screen/view/main_screen.dart';
import 'package:notesapp/presentation/screens/new_note/controller/new_note_cubit.dart';
import 'package:notesapp/presentation/screens/new_note/view/new_note_screen.dart';
import 'package:notesapp/presentation/screens/note_detail/controller/detail_note_state.dart';
import 'package:notesapp/presentation/screens/note_detail/controller/detial_note_cubit.dart';
import 'package:notesapp/presentation/screens/note_detail/view/detail_note_screen.dart';

class RouteGenerator {
  static const String initialPage = '/';
  static const String mainPage = '/mainPage';
  static const String newNotesPage = '/newNotesPage';
  static const String editNotesPage = '/editNotePage';
  static const String authenticaitonPage = '/AuthenticationPage';
  static const String detailPage = '/detailPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map map = {};

    if (settings.arguments != null) {
      map = settings.arguments as Map;
    }
    switch (settings.name) {
      case initialPage:
        return MaterialPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => AuthenticaitonCubit(),
                  child: const AuthenticationScreen(),
                ));

      case mainPage:
        return MaterialPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => MainScreenCubit(),
                  child: MainScreen(),
                ));

      case newNotesPage:
        return MaterialPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => NewNoteCubit(),
                  child: NewNoteScreen(),
                ));

      case editNotesPage:
        return MaterialPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => EditNoteCubit(map["note"]),
                  child: EditNoteScreen(),
                ));
      case detailPage:
        return MaterialPageRoute(
            builder: (ctx) => BlocProvider(
                  create: (context) => DetailNoteCubit(map["note"]),
                  child: DetailNoteScreen(),
                ));

      default:
        return MaterialPageRoute(builder: (ctx) => const ErrorPage());
    }
  }
}
