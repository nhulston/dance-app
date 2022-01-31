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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left: Style.width / 12),
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: Style.width / 12),
                const Icon(CupertinoIcons.checkmark_circle_fill, color: Style.accent),
                AppText.header(' Verified playlists')
              ],
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: Style.width / 12 - 10),
                  const _Playlist(name: 'Verified #1', image: ''),
                  const _Playlist(name: 'Verified #2', image: ''),
                  const _Playlist(name: 'Verified #3', image: ''),
                  const _Playlist(name: 'Verified #4', image: ''),
                  const _Playlist(name: 'Verified #5', image: ''),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: Style.width / 12),
              child: AppText.header('Recommended playlists'),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: Style.width / 12),
              child: AppText.header('Strength'),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: Style.width / 12),
              child: AppText.header('Flexibility'),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
          ],
        ),
      ),
      // child: Padding(
      //   padding: EdgeInsets.fromLTRB(Style.width / 12, 10, Style.width / 12, 0),
      //   child:
      // ),
    );
  }
}

class _Playlist extends StatefulWidget {
  const _Playlist({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  final String name;
  final String image;

  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<_Playlist> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: SizedBox(
        width: 100,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO image,
            Image.asset('assets/experience_icons/advanced.png'),
            const SizedBox(height: 10),
            AppText.boldSubtext(widget.name),
          ],
        ),
      ),
    );
  }
}

