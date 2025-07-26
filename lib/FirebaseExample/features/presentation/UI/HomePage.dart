import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b_sm/CLExample/UI/post_list_page.dart';
import 'package:flutter_b_sm/FirebaseExample/features/presentation/UI/MoviePage.dart';

import 'SignUpPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.data == null){
            return SignUpPage();
          }else{
            return MovieListScreen();
          }
        },
      ),
    );
  }
}
