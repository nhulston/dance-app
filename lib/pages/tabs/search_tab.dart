import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/components/app_textfield.dart';
import 'package:taneo/util/database_service.dart';
import 'package:taneo/util/style.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../components/genres_box.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _controller = TextEditingController();
  String _selected = '';
  static bool _gottenFromDB = false;

  static final Set<String> _searchSet = <String>{};
  static final Map<String, String> _tagsMap = HashMap<String, String>();
  static final Map<String, String> _imageMap = HashMap<String, String>();
  static final Map<String, Color> _colorsMap = HashMap<String, Color>();
  static final List<Color> _colors = [
    Colors.deepOrangeAccent,
    Colors.deepPurpleAccent,
    Colors.pink,
    Colors.blueAccent,
    Colors.redAccent
  ];
  static int _lastColor = -1;

  List<String> _search(String s) {
    s = s.toLowerCase();
    return _searchSet.where((element) =>
      element.toLowerCase().contains(s) || (_tagsMap.containsKey(element) && _tagsMap[element]!.contains(s))
    ).toList();
  }

  Color _nextColor() {
    _lastColor = (_lastColor + 1) % _colors.length;
    return _colors[_lastColor];
  }

  void _addToSet(String s, String image, String? tags) {
    _searchSet.add(s);
    if (tags != null) {
      _tagsMap[s] = tags;
    }
    _imageMap[s] = image;
    _colorsMap[s] = _nextColor();
  }

  @override
  void initState() {
    _addToSet('CAT: Legs (Strength)', 'legs1', null);
    _addToSet('CAT: Core (Strength)', 'core1', null);
    _addToSet('CAT: Hands (Strength)', 'hands1', null);
    _addToSet('CAT: Back (Strength)', 'back1', null);
    _addToSet('CAT: Feet (Strength)', 'feet1', null);
    _addToSet('CAT: Legs (Flexibility)', 'legs2', null);
    _addToSet('CAT: Feet (Flexibility)', 'feet2', null);
    _addToSet('CAT: Back (Flexibility)', 'back2', null);
    _addToSet('CAT: Shoulder (Flexibility)', 'shoulder1', null);
    _addToSet('CAT: Balance', 'balance1', null);
    _addToSet('CAT: Turnout', 'turnout2', null);
    _addToSet('CAT: Kicks', 'kicks1', null);
    _addToSet('CAT: Jumps', 'jumps1', null);
    _addToSet('CAT: Turns', 'turns1', null);
    _addToSet('CAT: Ballet', 'ballet1', null);
    _addToSet('CAT: Acrobatics', 'acrobatics1', null);
    _addToSet('CAT: Jazz', 'jazz1', null);

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(Style.width / 12, Platform.isAndroid ? 30 : 10, Style.width / 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.header('Search'),
              const SizedBox(height: 10),
              TypeAheadFormField(
                textFieldConfiguration: SimpleTextField.getTextFieldConfiguration(_controller,
                  () {
                    setState(() {});
                  },
                  () async {
                    if (!_gottenFromDB) {
                      _gottenFromDB = true;
                      log('[SearchTab init] Reading videos from db...');
                      for (var element in (await DatabaseService.getVideos().first).docs) {
                        String name = 'VID: ${element['name']}';
                        String tags = element['tags'];
                        String image = element['image'];
                        setState(() {
                          _addToSet(name, image, tags);
                        });
                        log('[SearchTab init] Adding to set ${element['name']}');
                      }
                    }
                  },
                ),
                suggestionsCallback: (pattern) {
                  return _search(pattern);
                },
                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                ),
                itemBuilder: (context, String suggestion) {
                  String category = suggestion.substring(0, 5);
                  String text = suggestion.substring(5);
                  double radius = 5;
                  if (category == 'VID: ') {
                    category = 'Video';
                  } else if (category == 'CAT: ') {
                    category = 'Category';
                    radius = 50;
                  } else {
                    category = 'Unknown';
                  }
                  return Column(
                    children: [
                      ListTile(
                        leading: Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(radius)),
                                color: _colorsMap[suggestion],
                              ),
                            ),
                            Positioned(
                              left: 9,
                              top: 9,
                              height: 32,
                              width: 32,
                              child: Image.asset(
                                'assets/image_icons/${_imageMap[suggestion] ?? 'turns'}.png',
                                scale: .1,
                              ),
                            ),
                          ],
                        ),
                        title: Text(text),
                        subtitle: Text(category),
                      ),
                      Divider(thickness: 1, color: Colors.grey.shade300, height: 0),
                    ],
                  );
                },
                noItemsFoundBuilder: (context) {
                  return const ListTile(
                    title: Text('No results found', textAlign: TextAlign.center),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (String suggestion) {
                  setState(() {
                    _controller.text = suggestion.substring(5);
                  });
                },
                onSaved: (String? value) {
                  setState(() {
                    _selected = value!.substring(5);
                  });
                }
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.only(bottom: 20),
                  primary: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  children: [
                    GenresBox(name: 'Strength', color: _colors[0], image: 'strength'),
                    GenresBox(name: 'Flexibility', color: _colors[1], image: 'flexibility'),
                    GenresBox(name: 'Balance', color: _colors[2], image: 'balance'),
                    GenresBox(name: 'Turnout', color: _colors[3], image: 'turnout'),
                    GenresBox(name: 'Kicks', color: _colors[4], image: 'kicks'),
                    GenresBox(name: 'Jumps', color: _colors[0], image: 'jumps'),
                    GenresBox(name: 'Turns', color: _colors[1], image: 'turns'),
                    GenresBox(name: 'Ballet', color: _colors[2], image: 'ballet'),
                    GenresBox(name: 'Acrobatics', color: _colors[3], image: 'acrobatics'),
                    GenresBox(name: 'Jazz', color: _colors[4], image: 'jazz'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
    );
  }
}

