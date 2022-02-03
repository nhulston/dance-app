import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/pages/settings.dart';
import 'package:taneo/util/style.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Padding(
            padding: EdgeInsets.only(left: Style.width / 12, top: Platform.isAndroid ? 20 : 0),
            child: Row(
              children: [
                AppText.header('Good morning'),  // TODO get time
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const Settings()
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings),
                ),
                SizedBox(width: Style.width / 12 - 10),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: Style.width / 12 - 10),
                const _Playlist(name: 'Recently played #1', image: ''),
                const _Playlist(name: 'Recently played #2', image: ''),
                const _Playlist(name: 'Recently played #3', image: ''),
                const _Playlist(name: 'Recently played #4', image: ''),
                const _Playlist(name: 'Recently played #5', image: ''),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              SizedBox(width: Style.width / 12),
              const Icon(CupertinoIcons.checkmark_circle_fill, color: Style.accent),
              AppText.header(' Verified playlists')
            ],
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: Style.width / 12 - 10),
                const _Playlist(name: 'Verified #1', image: '', scale: 1.35,),
                const _Playlist(name: 'Verified #2', image: '', scale: 1.35),
                const _Playlist(name: 'Verified #3', image: '', scale: 1.35),
                const _Playlist(name: 'Verified #4', image: '', scale: 1.35),
                const _Playlist(name: 'Verified #5', image: '', scale: 1.35),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: Style.width / 12),
            child: AppText.header('Recommended playlists'),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: Style.width / 12 - 10),
                const _Playlist(name: 'Recommended #1', image: ''),
                const _Playlist(name: 'Recommended #2', image: ''),
                const _Playlist(name: 'Recommended #3', image: ''),
                const _Playlist(name: 'Recommended #4', image: ''),
                const _Playlist(name: 'Recommended #5', image: ''),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.only(left: Style.width / 12),
            child: AppText.header('Strength'),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: Style.width / 12 - 10),
                const _Playlist(name: 'Strength #1', image: ''),
                const _Playlist(name: 'Strength #2', image: ''),
                const _Playlist(name: 'Strength #3', image: ''),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.only(left: Style.width / 12),
            child: AppText.header('Flexibility'),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: Style.width / 12 - 10),
                const _Playlist(name: 'Flexibility #1', image: ''),
                const _Playlist(name: 'Flexibility #2', image: ''),
                const _Playlist(name: 'Flexibility #3', image: ''),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _Playlist extends StatefulWidget {
  const _Playlist({
    Key? key,
    required this.name,
    required this.image,
    this.scale,
  }) : super(key: key);

  final String name;
  final String image;
  final double? scale;

  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<_Playlist> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: SizedBox(
        width: 100 * (widget.scale ?? 1),
        height: 150 * (widget.scale ?? 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO image,
            Image.asset('assets/experience_icons/advanced.png'),
            const SizedBox(height: 10),
            AppText.boldSubtext(widget.name, widget.scale ?? 1),
          ],
        ),
      ),
    );
  }
}

