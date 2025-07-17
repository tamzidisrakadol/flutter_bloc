import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../BloC/song_bloc.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({super.key});

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {

  @override
  void initState() {
    BlocProvider.of<MusicPlayerBloc>(context).add(LoadSongsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Music Player')),
      body: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
        builder: (context, state) {
          if (state is MusicPlayerInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MusicPlayerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MusicPlayerError) {
            return Center(child: Text(state.message));
          } else if (state is MusicPlayerLoaded) {
            return ListView.builder(
              itemCount: state.songs.length,
              itemBuilder: (context, index) {
                final song = state.songs[index];
                return ListTile(
                  title: Text(song.title),
                  subtitle: Text(song.artist),
                  onTap: () {
                    // Play the song
                  },
                );
              },
            );
          }
          // else if (state is MusicPlayerPermissionError) {
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(state.message),
          //         const SizedBox(height: 20),
          //         ElevatedButton(
          //           onPressed: () {
          //             context.read<MusicPlayerBloc>().add(RequestPermissionsEvent());
          //           },
          //           child: const Text('Grant Permission'),
          //         ),
          //         const SizedBox(height: 10),
          //         ElevatedButton(
          //           onPressed: () async {
          //             await openAppSettings();
          //           },
          //           child: const Text('Open Settings'),
          //         ),
          //       ],
          //     ),
          //   );
          // }
          return Container();
        },
      ),
    );
  }
}