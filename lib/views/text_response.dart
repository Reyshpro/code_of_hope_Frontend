import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

import 'dart:async';

import '../backend/api.dart';


class TypewriterText extends StatefulWidget {
  final String text;
  final Duration duration;

  const TypewriterText(
      {Key? key,
        required this.text,
        this.duration = const Duration(milliseconds: 100)})
      : super(key: key);

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayText = '';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, (timer) {
      if (_displayText.length < widget.text.length) {
        setState(() {
          _displayText += widget.text[_displayText.length];
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GptMarkdown(_displayText,
        textDirection: TextDirection.rtl,
        style: TextStyle(color: Colors.black, fontSize: 14));
  }
}

class AskAIPage extends StatefulWidget {
  AskAIPage({super.key, required this.resp });
  final List<dynamic> resp;

  @override
  State<AskAIPage> createState() => _AskAIPageState();
}

class _AskAIPageState extends State<AskAIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: const Color.fromARGB(
              255, 255, 255, 255), //change your color here
        ),
        title:  Text('مساعدة', style: TextStyle(color:Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),
      // backgroundColor:,
      body: Container(
        // height: 70.h,
          width: double.infinity,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(20),
          //   color: Colors.white,
          // ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(20),
          child: Flexible(
            child: SingleChildScrollView(
                child: TypewriterText(
                  text: widget.resp[0],
                  duration: Duration(milliseconds: 5),
                )),
          )),
    );
  }
}