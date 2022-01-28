import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_deepl/widgets/Inherited/language_scope.dart';
import 'package:translator_deepl/widgets/translate_screen/country_list.dart';

import 'main_translete_widget.dart';

class LanguageChange extends StatefulWidget {
  const LanguageChange({Key? key, required this.targetOrCurrent})
      : super(key: key);
  final LanType targetOrCurrent;

  @override
  _LanguageChangeState createState() => _LanguageChangeState();
}

class _LanguageChangeState extends State<LanguageChange> {
  final _langConroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ColoredBox(
              color: const Color(0xff303134),
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          IconButton(
                            color: Colors.black,
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 40, top: 5),
                      child: TextField(
                        controller: _langConroller,
                        cursorWidth: 3,
                        cursorRadius: const Radius.circular(6),
                        cursorHeight: 20,
                        cursorColor: Colors.purple,
                        decoration: InputDecoration(
                          hintText: 'Поиск языка',
                          hintStyle: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                          constraints: const BoxConstraints(
                              maxHeight: 50, minHeight: 50),
                          border: InputBorder.none,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Flexible(
              child: ValueListenableBuilder(
                valueListenable: _langConroller,
                builder: (context, TextEditingValue text, _) {
                  return LanguageList(
                    targetOrCurrent: widget.targetOrCurrent,
                    countries: Country.country
                        .where(
                          (element) => element['name']!
                              .toLowerCase()
                              .contains(text.text.toLowerCase()),
                        )
                        .toList(),
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
      {Key? key, required this.countries, required this.targetOrCurrent})
      : super(key: key);
  final List<Map<String, String>> countries;
  final LanType targetOrCurrent;

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
              log(widget.targetOrCurrent.toString()),
              if (widget.targetOrCurrent == LanType.current)
                {
                  LanguageScope.of(context)
                      .changeCurrentLang(widget.countries[index]['name']!),
                  LanguageScope.of(context).changeRequestCurrentLanguage(
                      widget.countries[index]['code']!),
                  log(LanguageScope.of(context).requestCurrentLanguage),
                  Navigator.pop(context),
                }
              else if (widget.targetOrCurrent == LanType.target)
                {
                  LanguageScope.of(context)
                      .changeTargetLang(widget.countries[index]['name']!),
                  LanguageScope.of(context).changeRequestTargetLang(
                      widget.countries[index]['code']!),
                  log(LanguageScope.of(context).),
                  Navigator.pop(context),
                }
            },
            child: ListTile(
              tileColor: const Color(0xff202020),
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
