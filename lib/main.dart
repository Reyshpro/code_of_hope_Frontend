import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salam_hackathon_front/backend/api.dart';
import 'package:salam_hackathon_front/controllers/main_controller.dart';
import 'package:salam_hackathon_front/views/learning_card.dart';
import 'package:salam_hackathon_front/views/new_learning.dart';
import 'package:salam_hackathon_front/views/suggest_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder:(controller)=> Scaffold(

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0), // Set the desired height here
          child: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  SuggestBottomSheet.show(
                    context,
                    (learningData) {
                      // Handle the new learning data
                      print(learningData);
                      // Navigate or update state as needed
                    },
                  );
                },
                icon: const Icon(Icons.help_outline),
              ),
            ],
            titleSpacing: 10,
            backgroundColor: Colors.blueAccent,
            title: const Text(
              '!استعد لاكتشاف عالم البرمجة وتطوير مهاراتك',
              maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.end,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(future: getLearnings(controller.sessionid), builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                }
                if (snapshot.data?.length == 0) {
                  return const Center(child: Text('لايوجد مسارات'));
                }
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return LearningCard(l: snapshot.data![index]);
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
                    NewJourneyBottomSheet.show(
                      context,

                          (journeyData) {
                        // Handle the new journey data
                        print(journeyData);
                        // Navigate or update state as needed
                      },
                    );
                  },
                  child: const Text('Button Text', style: TextStyle(color: Colors.white),), // Add text or other content here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
