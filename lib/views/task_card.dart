import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salam_hackathon_front/backend/api.dart';
import 'package:salam_hackathon_front/controllers/main_controller.dart';
import 'package:salam_hackathon_front/models/models.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.t});

  final Task t ;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    bool comp = widget.t.completed;
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
          Checkbox(value: comp, onChanged:comp ? (val){} : (val){
            comp = true;
              final controller = Get.find<MainController>();
              checkTask(controller.sessionid, widget.t.id).then((value) {
                setState(() {


              });
            });

          }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(widget.t.title, style: TextStyle(fontSize: 20),),
              Text(widget.t.description, style: TextStyle(fontSize: 16,),textAlign: TextAlign.end,maxLines: 3),
            ],
          ),
        ],
      ),
    );
  }
}
