import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:salam_hackathon_front/backend/api.dart';
import 'package:salam_hackathon_front/controllers/main_controller.dart';

class NewJourneyBottomSheet extends StatefulWidget {

  const NewJourneyBottomSheet({Key? key}) : super(key: key);

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
              child: NewJourneyBottomSheet(),
            );
          },
        );
      },
    );
  }

  @override
  _NewJourneyBottomSheetState createState() => _NewJourneyBottomSheetState();
}

class _NewJourneyBottomSheetState extends State<NewJourneyBottomSheet> {
  String? language;
  String? framework;
  String? goal;
  String? level;

  final Map<String, List<Map<String, String>>> frameworksByLanguage = {
    'python': [
      {'label': 'Django', 'value': 'django'},
      {'label': 'Flask', 'value': 'flask'},
      {'label': 'FastAPI', 'value': 'fastapi'},
      {'label': 'TensorFlow', 'value': 'tensorflow'},
      {'label': 'PyTorch', 'value': 'pytorch'},
      {'label': 'OpenCV', 'value': 'opencv'},
      {'label': 'Pandas', 'value': 'pandas'},
      {'label': 'NumPy', 'value': 'numpy'},
      {'label': 'Scrapy', 'value': 'scrapy'},
      {'label': 'PyGame', 'value': 'pygame'},
    ],
    'javascript': [
      {'label': 'React.js', 'value': 'react'},
      {'label': 'Angular', 'value': 'angular'},
      {'label': 'Vue.js', 'value': 'vue'},
      {'label': 'Express.js', 'value': 'express'},
      {'label': 'Node.js', 'value': 'node'},
      {'label': 'Next.js', 'value': 'next'},
      {'label': 'Nuxt.js', 'value': 'nuxt'},
      {'label': 'Electron.js', 'value': 'electron'},
      {'label': 'Svelte', 'value': 'svelte'},
      {'label': 'NestJS', 'value': 'nest'},
    ],
    'cpp': [
      {'label': 'Qt', 'value': 'qt'},
      {'label': 'Boost', 'value': 'boost'},
      {'label': 'Unreal Engine', 'value': 'unreal'},
      {'label': 'Cocos2d-x', 'value': 'cocos2d'},
      {'label': 'OpenCV', 'value': 'opencv'},
      {'label': 'SFML', 'value': 'sfml'},
      {'label': 'CUDA', 'value': 'cuda'},
      {'label': 'POCO C++', 'value': 'poco'},
      {'label': 'JUCE', 'value': 'juce'},
      {'label': 'Catch2', 'value': 'catch2'},
    ],
    'java': [
      {'label': 'Spring Boot', 'value': 'spring'},
      {'label': 'Hibernate', 'value': 'hibernate'},
      {'label': 'JavaFX', 'value': 'javafx'},
      {'label': 'Apache Struts', 'value': 'struts'},
      {'label': 'Play Framework', 'value': 'play'},
      {'label': 'Vaadin', 'value': 'vaadin'},
      {'label': 'Micronaut', 'value': 'micronaut'},
      {'label': 'JUnit', 'value': 'junit'},
      {'label': 'Quarkus', 'value': 'quarkus'},
      {'label': 'Jakarta EE', 'value': 'jakarta'},
    ],
    'csharp': [
      {'label': '.NET Core', 'value': 'dotnet'},
      {'label': 'ASP.NET', 'value': 'aspnet'},
      {'label': 'Entity Framework', 'value': 'ef'},
      {'label': 'Unity', 'value': 'unity'},
      {'label': 'Blazor', 'value': 'blazor'},
      {'label': 'Xamarin', 'value': 'xamarin'},
      {'label': 'WPF', 'value': 'wpf'},
      {'label': 'SignalR', 'value': 'signalr'},
      {'label': 'NancyFX', 'value': 'nancy'},
      {'label': 'NLog', 'value': 'nlog'},
    ],
    'swift': [
      {'label': 'SwiftUI', 'value': 'swiftui'},
      {'label': 'UIKit', 'value': 'uikit'},
      {'label': 'Vapor', 'value': 'vapor'},
      {'label': 'CoreData', 'value': 'coredata'},
      {'label': 'Combine', 'value': 'combine'},
      {'label': 'RxSwift', 'value': 'rxswift'},
      {'label': 'Alamofire', 'value': 'alamofire'},
      {'label': 'SpriteKit', 'value': 'spritekit'},
      {'label': 'SceneKit', 'value': 'scenekit'},
      {'label': 'TensorFlow Swift', 'value': 'tensorflow-swift'},
    ],
    'kotlin': [
      {'label': 'Ktor', 'value': 'ktor'},
      {'label': 'Jetpack Compose', 'value': 'compose'},
      {'label': 'Spring Boot', 'value': 'spring'},
      {'label': 'Android Jetpack', 'value': 'jetpack'},
      {'label': 'Koin', 'value': 'koin'},
      {'label': 'SQLDelight', 'value': 'sqldelight'},
      {'label': 'Exposed', 'value': 'exposed'},
      {'label': 'TornadoFX', 'value': 'tornadofx'},
      {'label': 'Dagger', 'value': 'dagger'},
      {'label': 'Retrofit', 'value': 'retrofit'},
    ],
    'php': [
      {'label': 'Laravel', 'value': 'laravel'},
      {'label': 'Symfony', 'value': 'symfony'},
      {'label': 'CodeIgniter', 'value': 'codeigniter'},
      {'label': 'Zend Framework', 'value': 'zend'},
      {'label': 'CakePHP', 'value': 'cake'},
      {'label': 'Yii', 'value': 'yii'},
      {'label': 'Slim', 'value': 'slim'},
      {'label': 'Phalcon', 'value': 'phalcon'},
      {'label': 'Drupal', 'value': 'drupal'},
      {'label': 'Magento', 'value': 'magento'},
    ],
    'ruby': [
      {'label': 'Ruby on Rails', 'value': 'rails'},
      {'label': 'Sinatra', 'value': 'sinatra'},
      {'label': 'Hanami', 'value': 'hanami'},
      {'label': 'Padrino', 'value': 'padrino'},
      {'label': 'Grape', 'value': 'grape'},
      {'label': 'Sidekiq', 'value': 'sidekiq'},
      {'label': 'RSpec', 'value': 'rspec'},
      {'label': 'Sequel', 'value': 'sequel'},
      {'label': 'Capybara', 'value': 'capybara'},
      {'label': 'Devise', 'value': 'devise'},
    ],
    'typescript': [
      {'label': 'Angular', 'value': 'angular'},
      {'label': 'NestJS', 'value': 'nest'},
      {'label': 'Next.js', 'value': 'next'},
      {'label': 'Nuxt.js', 'value': 'nuxt'},
      {'label': 'Express.js', 'value': 'express'},
      {'label': 'Vue.js', 'value': 'vue'},
      {'label': 'Ionic', 'value': 'ionic'},
      {'label': 'Electron', 'value': 'electron'},
      {'label': 'RxJS', 'value': 'rxjs'},
      {'label': 'Deno', 'value': 'deno'},
    ],
    'go': [
      {'label': 'Gin', 'value': 'gin'},
      {'label': 'Echo', 'value': 'echo'},
      {'label': 'Fiber', 'value': 'fiber'},
      {'label': 'Revel', 'value': 'revel'},
      {'label': 'Beego', 'value': 'beego'},
      {'label': 'GORM', 'value': 'gorm'},
      {'label': 'Go Kit', 'value': 'gokit'},
      {'label': 'Buffalo', 'value': 'buffalo'},
      {'label': 'Kratos', 'value': 'kratos'},
      {'label': 'Cobra', 'value': 'cobra'},
    ],
    'rust': [
      {'label': 'Rocket', 'value': 'rocket'},
      {'label': 'Actix', 'value': 'actix'},
      {'label': 'Axum', 'value': 'axum'},
      {'label': 'Tokio', 'value': 'tokio'},
      {'label': 'Diesel', 'value': 'diesel'},
      {'label': 'Warp', 'value': 'warp'},
      {'label': 'Serde', 'value': 'serde'},
      {'label': 'Tauri', 'value': 'tauri'},
      {'label': 'Yew', 'value': 'yew'},
      {'label': 'Bevy', 'value': 'bevy'},
    ],
    'r': [
      {'label': 'Shiny', 'value': 'shiny'},
      {'label': 'ggplot2', 'value': 'ggplot2'},
      {'label': 'Tidyverse', 'value': 'tidyverse'},
      {'label': 'Plumber', 'value': 'plumber'},
      {'label': 'R Markdown', 'value': 'rmarkdown'},
      {'label': 'Data.table', 'value': 'datatable'},
      {'label': 'Caret', 'value': 'caret'},
      {'label': 'Rcpp', 'value': 'rcpp'},
      {'label': 'Bioconductor', 'value': 'bioconductor'},
      {'label': 'Plotly', 'value': 'plotly'},
    ],
    'dart': [
      {'label': 'Flutter', 'value': 'flutter'},
      {'label': 'Aqueduct', 'value': 'aqueduct'},
      {'label': 'Angel', 'value': 'angel'},
      {'label': 'Shelf', 'value': 'shelf'},
      {'label': 'RxDart', 'value': 'rxdart'},
      {'label': 'Dart Frog', 'value': 'dartfrog'},
      {'label': 'Mason', 'value': 'mason'},
      {'label': 'GetX', 'value': 'getx'},
      {'label': 'Riverpod', 'value': 'riverpod'},
      {'label': 'Flame', 'value': 'flame'},
    ],
    'sql': [
      {'label': 'MySQL', 'value': 'mysql'},
      {'label': 'PostgreSQL', 'value': 'postgresql'},
      {'label': 'SQLite', 'value': 'sqlite'},
      {'label': 'Microsoft SQL Server', 'value': 'mssql'},
      {'label': 'Oracle DB', 'value': 'oracle'},
      {'label': 'Redis', 'value': 'redis'},
      {'label': 'Apache Cassandra', 'value': 'cassandra'},
      {'label': 'Firebase Firestore', 'value': 'firestore'},
      {'label': 'Amazon RDS', 'value': 'rds'},
      {'label': 'GraphQL', 'value': 'graphql'},
    ],
  };
  final List<Map<String, String>> languages = [
    {'label': 'Python', 'value': 'python'},
    {'label': 'JavaScript', 'value': 'javascript'},
    {'label': 'C++', 'value': 'cpp'},
    {'label': 'Java', 'value': 'java'},
    {'label': 'C#', 'value': 'csharp'},
    {'label': 'Swift', 'value': 'swift'},
    {'label': 'Kotlin', 'value': 'kotlin'},
    {'label': 'PHP', 'value': 'php'},
    {'label': 'Ruby', 'value': 'ruby'},
    {'label': 'TypeScript', 'value': 'typescript'},
    {'label': 'Go', 'value': 'go'},
    {'label': 'Rust', 'value': 'rust'},
    {'label': 'R', 'value': 'r'},
    {'label': 'Dart', 'value': 'dart'},
    {'label': 'SQL', 'value': 'sql'},
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

  List<Map<String, String>> _getFrameworksForLanguage() {
    if (language == null || !frameworksByLanguage.containsKey(language)) {
      return [];
    }
    return frameworksByLanguage[language]!;
  }
  late MainController controller;
  void _handleAddJourney() {
    controller = Get.find<MainController>();
    if (language == null || framework == null || goal == null || level == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء ملء جميع الحقول', textAlign: TextAlign.right)),
      );
      return;
    }

    newLearning(controller.sessionid, language, framework, goal, level).then((response) {
      if (response) {
        // final Map<String, dynamic> data = jsonDecode(response.body);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تمت إضافة الرحلة بنجاح', textAlign: TextAlign.right),
          ),
        );
        controller.refresh();
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
                      label: 'اختر لغة البرمجة',
                      value: language,
                      items: languages,
                      onChanged: (value) {
                        setState(() {
                          language = value;
                          framework = null;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildDropdown(
                      label: 'اختر إطار عمل',
                      value: framework,
                      items: _getFrameworksForLanguage(),
                      onChanged: (value) {
                        setState(() {
                          framework = value;
                        });
                      },
                      enabled: language != null,
                    ),
                    const SizedBox(height: 24),
                    _buildDropdown(
                      label: 'اختر هدفك',
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
                      label: 'اختر مستواك',
                      value: level,
                      items: levels,
                      onChanged: (value) {
                        setState(() {
                          level = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: language != null && framework != null && goal != null && level != null
                  ? _handleAddJourney
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
