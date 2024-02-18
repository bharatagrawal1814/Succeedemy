import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:succeedemy/features/home/widgets/subjects_screen.dart';
import 'package:succeedemy/provider/user_provider.dart';
import 'package:succeedemy/utils/global_variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final studentClass =
        Provider.of<UserProvider>(context, listen: false).user.studentClass;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'All Subjects',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: subjects
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SubjectScreen.routeName,
                              arguments: {
                                'subject': e['subject'],
                                'studentClass': studentClass
                              });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green[100],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.science,
                                size: 50,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                e['subject']!,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
