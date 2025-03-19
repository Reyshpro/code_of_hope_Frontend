import 'package:flutter/material.dart';
import 'package:salam_hackathon_front/models/models.dart';

import 'learning_page.dart';

class LearningCard extends StatelessWidget {
  const LearningCard({super.key, required this.l});

  final Learning l;

  void deleteLearning(BuildContext context) {
    // منطق الحذف هنا
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حذف المسار بنجاح', textAlign: TextAlign.right),
        backgroundColor: Colors.red,
      ),
    );
  }

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
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => deleteLearning(context),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    l.level,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${l.language} - ${l.framework}",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l.description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.end,
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            buildProgressBar(l.progress, 5),
          ],
        ),
      ),
    );
  }
}
