import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class LibraryTab extends StatelessWidget {
  const LibraryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: const [
          SizedBox(
            height: 50,
            child: VimeoPlayer(
              videoId: '70591644',
            ),
          ),
          SizedBox(
            height: 50,
            child: VimeoPlayer(
              videoId: '70591644',
            ),
          ),
        ],
      ),
    );
  }
}