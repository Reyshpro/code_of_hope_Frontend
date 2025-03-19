import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salam_hackathon_front/backend/api.dart';
import 'package:salam_hackathon_front/controllers/main_controller.dart';
import 'package:salam_hackathon_front/models/models.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.t});

  final Task t;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool comp;
  bool isLoading = false; // لتتبع حالة الانتظار

  @override
  void initState() {
    super.initState();
    comp = widget.t.completed;
  }

  void _handleCheck(bool? value) async {
    if (comp || isLoading)
      return; // لا تقم بأي شيء إذا كانت مكتملة بالفعل أو جاري المعالجة

    final controller = Get.find<MainController>();

    setState(() {
      isLoading = true; // بدء مؤشر التحميل
    });

    final success = await checkTask(controller.sessionid, widget.t.id);
    print(success);
    setState(() {
      isLoading = false; // إيقاف مؤشر التحميل
      if (success) {
        comp = true; // تحديث الحالة عند نجاح الاستجابة
        controller.update(); // تحديث الصفحة الرئيسية
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('حدث خطأ أثناء تحديث المهمة، الرجاء المحاولة مرة أخرى'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isLoading
              ? const CircularProgressIndicator() // مؤشر تحميل أثناء التحديث
              : Checkbox(
                  value: comp,
                  onChanged: _handleCheck,
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(widget.t.title, style: const TextStyle(fontSize: 20)),
              Text(
                widget.t.description,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.end,
                maxLines: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
