import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Inherited/language_scope.dart';
import '../../data/country_list.dart';
import '../translate/main_translate_widget.dart';

class LanguageChange extends StatefulWidget {
  const LanguageChange({Key? key, required this.currentOrTarget})
      : super(key: key);
  final LanType currentOrTarget;

  @override
  _LanguageChangeState createState() => _LanguageChangeState();
}

class _LanguageChangeState extends State<LanguageChange> {
  final _langController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 75, 75, 75),
        body: Column(
          children: [
            ColoredBox(
              color: const Color.fromARGB(255, 75, 75, 75),
              child: SizedBox(
                child: Row(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 6,
                        ),
                        IconButton(
                          color: Colors.black,
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 40, top: 5),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _langController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          hintText: 'Поиск языка',
                          hintStyle: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                          constraints: const BoxConstraints(
                              maxHeight: 50, minHeight: 50),
                          border: InputBorder.none,
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
            Flexible(
              child: ValueListenableBuilder(
                valueListenable: _langController,
                builder: (context, TextEditingValue text, _) {
                  return LanguageList(
                    countries: widget.currentOrTarget == LanType.target
                        ? Country.countryForTarget
                            .where(
                              (element) => element['name']!
                                  .toLowerCase()
                                  .contains(text.text.toLowerCase()),
                            )
                            .toList()
                        : Country.countryForCurrent
                            .where(
                              (element) => element['name']!
                                  .toLowerCase()
                                  .contains(text.text.toLowerCase()),
                            )
                            .toList(),
                    currentOrTarget: widget.currentOrTarget,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LanguageList extends StatefulWidget {
  const LanguageList(
      {Key? key, required this.countries, required this.currentOrTarget})
      : super(key: key);
  final List<Map<String, String>> countries;
  final LanType currentOrTarget;

  @override
  State<LanguageList> createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.countries.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => {
              if (widget.currentOrTarget == LanType.current)
                {
                  LanguageScope.of(context)
                      .changeCurrentLang(widget.countries[index]),
                  Navigator.pop(context)
                },
              if (widget.currentOrTarget == LanType.target)
                {
                  LanguageScope.of(context)
                      .changeTargetLang(widget.countries[index]),
                  Navigator.pop(context)
                }
            },
            child: ListTile(
              tileColor: const Color.fromARGB(255, 51, 51, 51),
              title: Text(
                widget.countries[index]['name']!,
                style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          );
        });
  }
}
