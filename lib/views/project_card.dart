import 'package:flutter/material.dart';
import 'package:salam_hackathon_front/models/models.dart';
import 'package:salam_hackathon_front/views/project_page.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.p, required this.language, required this.framework});

  final Project p ;
  final String language, framework;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: p.isLocked ? (){} : () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectPage(p: p, language: language, framework: framework),
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
                Text(p.title, style: TextStyle(fontSize: 20),),
                Text(p.description, style: TextStyle(fontSize: 16,),textAlign: TextAlign.end,maxLines: 3),
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
              child: Icon(Icons.lock, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }
}
