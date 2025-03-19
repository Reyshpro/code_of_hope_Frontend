import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:salam_hackathon_front/backend/api.dart';
import 'package:salam_hackathon_front/controllers/main_controller.dart';
import 'package:salam_hackathon_front/views/text_response.dart';

class SuggestBottomSheet extends StatefulWidget {

  const SuggestBottomSheet({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context, Function(Map<String, dynamic>) onAddJourney) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SuggestBottomSheet(),
            );
          },
        );
      },
    );
  }

  @override
  _SuggestBottomSheetState createState() => _SuggestBottomSheetState();
}

class _SuggestBottomSheetState extends State<SuggestBottomSheet> {
  String? preference;
  String? goal;
  String? level;

  final List<Map<String, String>> preferences = [
    {'label': 'OOP Language', 'value': 'OOP Language'},
    {'label': 'Functional Language', 'value': 'Functional Language'},
    {'label': 'Scripting Language', 'value': 'Scripting Language'},
    {'label': 'Markup Language', 'value': 'Markup Language'},
  ];

  final List<Map<String, String>> goals = [
    {'label': 'أهدف إلى التخصص في تطوير الويب', 'value': 'web_development'},
    {'label': 'أهدف إلى التخصص في تطوير تطبيقات الموبايل', 'value': 'mobile_development'},
    {'label': 'أهدف إلى التخصص في تطوير الألعاب', 'value': 'game_development'},
    {'label': 'أهدف إلى التخصص في علم البيانات والذكاء الاصطناعي', 'value': 'ai_data_science'},
    {'label': 'أهدف إلى التخصص في الأمن السيبراني', 'value': 'cybersecurity'},
    {'label': 'أهدف إلى التخصص في تحليل البيانات', 'value': 'data_analysis'},
    {'label': 'أهدف إلى التخصص في الأنظمة المدمجة وإنترنت الأشياء', 'value': 'iot_embedded'},
  ];

  final List<Map<String, String>> levels = [
    {'label': 'مبتدئ', 'value': 'مبتدئ'},
    {'label': 'متوسط', 'value': 'متوسط'},
    {'label': 'متقدم', 'value': 'متقدم'},
  ];


  late MainController controller;
  void _handleRequestSuggest() {
    controller = Get.find<MainController>();
    if (preference == null || goal == null || level == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء ملء جميع الحقول', textAlign: TextAlign.right)),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    getSuggest(level!, goal, preference).then((response) {
      Navigator.pop(context); // Hide loading indicator
      if (response.isNotEmpty) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AskAIPage(resp: response)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ ما، الرجاء المحاولة مرة أخرى', textAlign: TextAlign.right),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => Navigator.of(context).pop(),
                  color: const Color(0xFF4E7ED1),
                ),
                const Spacer(),
              ],
            ),
            const Text(
              'إبدأ رحلة جديدة',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E7ED1),
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 8),
            const Text(
              'اختر لغة البرمجة وإطار العمل والأهداف التي تريد تحقيقها',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF666666),
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDropdown(
                      label: 'اختر الهدف',
                      value: goal,
                      items: goals,
                      onChanged: (value) {
                        setState(() {
                          goal = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildDropdown(
                      label: 'اختر المستوى',
                      value: level,
                      items: levels,
                      onChanged: (value) {
                        setState(() {
                          level = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildDropdown(
                      label: 'اختر تفضيلاتك',
                      value: preference,
                      items: preferences,
                      onChanged: (value) {
                        setState(() {
                          preference = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: preference != null && goal != null && level != null
                  ? _handleRequestSuggest
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E7ED1),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                disabledBackgroundColor: Colors.grey[300],
              ),
              child: const Text(
                'إضافة رحلة جديدة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<Map<String, String>> items,
    required Function(String?) onChanged,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF4E7ED1),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E5E5)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
            ),
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 16,
            ),
            onChanged: enabled ? onChanged : null,
            items: items.map<DropdownMenuItem<String>>((Map<String, String> item) {
              return DropdownMenuItem<String>(
                value: item['value'],
                child: Text(
                  item['label']!,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            hint: Text(
              'اختر ${label.split(' ').last}',
              style: const TextStyle(color: Color(0xFF999999)),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
