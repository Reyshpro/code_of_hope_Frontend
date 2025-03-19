import 'package:flutter/material.dart';
import 'package:salam_hackathon_front/models/models.dart';

import 'learning_page.dart';

class LearningCard extends StatelessWidget {
  const LearningCard({super.key, required this.l});

  final Learning l ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LearningPage(l: l),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
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
            Row(

              children: [
                Container(

                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:  Text(
                    l.level,
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Spacer(),
                Text("${l.language} - ${l.framework}", style: TextStyle(fontSize: 20),),
              ],
            ),
            Text(l.description, style: TextStyle(fontSize: 16,),textAlign: TextAlign.end, maxLines: 3,),
          ],
        ),
      ),
    );
  }
}
