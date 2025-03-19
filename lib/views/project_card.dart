import 'package:flutter/material.dart';
import 'package:salam_hackathon_front/models/models.dart';
import 'package:salam_hackathon_front/views/project_page.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard(
      {super.key,
      required this.p,
      required this.language,
      required this.framework});

  final Project p;
  final String language, framework;

  Widget buildProgressBar(int progress, int totalSteps) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index % 2 == 0) {
          bool isCompleted = index ~/ 2 < progress;
          return Icon(
            Icons.diamond,
            color: isCompleted ? Colors.yellow : Colors.grey,
            size: 16,
          );
        } else {
          bool isPreviousCompleted = (index ~/ 2) < progress;
          return Expanded(
            child: Container(
              height: 4,
              color: isPreviousCompleted ? Colors.blue : Colors.grey[300],
            ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: p.isLocked
          ? () {}
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectPage(
                      p: p, language: language, framework: framework),
                ),
              );
            },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  spreadRadius: 0.5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  p.title,
                  style: TextStyle(fontSize: 20),
                ),
                Text(p.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 3),
                const SizedBox(height: 8),
                buildProgressBar(p.progress, p.tasknum),
              ],
            ),
          ),
          Visibility(
            visible: p.isLocked,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.lock,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
