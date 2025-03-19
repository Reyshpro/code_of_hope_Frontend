import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salam_hackathon_front/backend/api.dart';
import 'package:salam_hackathon_front/controllers/main_controller.dart';
import 'package:salam_hackathon_front/views/project_card.dart';
import 'package:salam_hackathon_front/views/task_card.dart';
import 'package:salam_hackathon_front/views/text_response.dart';

import '../models/models.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage(
      {super.key,
      required this.p,
      required this.language,
      required this.framework});
  final Project p;
  final String language, framework;
  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List<Task> tasks = [];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: const Color.fromARGB(
                255, 255, 255, 255), //change your color here
          ),
          backgroundColor: Colors.blueAccent,
          title: Text(
            widget.p.title,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontSize: 24),
            textAlign: TextAlign.end,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getTasks(controller.sessionid, widget.p.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error'));
                    }
                    tasks = snapshot.data as List<Task>;
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return TaskCard(t: snapshot.data![index]);
                      },
                    );
                  }),
            ),
            Container(
              height: 50,
              // padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox.expand(
                child: MaterialButton(
                  onPressed: () {
                    try {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      final currentTask = tasks
                          .firstWhere((element) => element.completed == false);

                      getHelp(widget.language, widget.framework, widget.p.title,
                              currentTask.description)
                          .then((value) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AskAIPage(resp: value),
                          ),
                        );
                      });
                    } catch (e) {
                      Navigator.pop(context);
                      print("Eroooorrrrrrrrrr");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            '!جميع المهام مكتملة',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3), // مدة العرض
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Help',
                    style: TextStyle(color: Colors.white),
                  ), // Add text or other content here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
