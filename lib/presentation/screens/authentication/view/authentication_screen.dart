import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesapp/core/routing/route_generator.dart';
import 'package:notesapp/presentation/screens/authentication/controller/authentication_cubit.dart';
import 'package:notesapp/presentation/screens/authentication/controller/authentication_state.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        BlocBuilder<AuthenticaitonCubit, AuthenticationState>(
            builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Login to continue",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 40),
                // Image.asset('assets/login_image.png', height: 180),
                // Icon(Icons.login),
                SizedBox(height: 40),
                ElevatedButton.icon(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.asset('assets/images/google.png',
                        width: 30, height: 30),
                  ),
                  onPressed: () async {
                    if (await context
                        .read<AuthenticaitonCubit>()
                        .signInWithGoogle()) {
                      Navigator.pushReplacementNamed(
                          context, RouteGenerator.mainPage);
                    } else {
                      Fluttertoast.showToast(msg: "Error while Signing in....");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  label: Text("Sign in with Google"),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.asset('assets/images/apple-logo.png',
                        color: Colors.white, width: 30, height: 30),
                  ),
                  onPressed: () async {
                    if (await context
                        .read<AuthenticaitonCubit>()
                        .signInWithApple()) {
                      Navigator.pushReplacementNamed(
                          context, RouteGenerator.mainPage);
                    } else {
                      Fluttertoast.showToast(msg: "Error while Signing in....");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  label: Text(
                    "Sign in with Apple",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 24),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Need help? Contact Support",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
