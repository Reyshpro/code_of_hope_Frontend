import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salam_hackathon_front/backend/api.dart';
import 'package:salam_hackathon_front/controllers/main_controller.dart';
import 'package:salam_hackathon_front/views/project_card.dart';

import '../models/models.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key, required this.l});
  final Learning l;
  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) => Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            "${widget.l.language} - ${widget.l.framework}",
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontSize: 24),
            textAlign: TextAlign.end,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(future: getProjects(controller.sessionid, widget.l.id ), builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                }
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ProjectCard(p: snapshot.data![index], framework: widget.l.framework,language: widget.l.language,);
                  },
                );
              }),
            ),

          ],
        ),
      ),
    );
  }
}
