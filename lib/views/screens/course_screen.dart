import 'package:flutter/material.dart';
import 'package:lesson50/viewmodel/course_view_model.dart';
import 'package:lesson50/views/screens/course_admin.dart';
import 'package:lesson50/views/screens/course_description.dart';

class CourseListScreen extends StatefulWidget {
  CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final courseViewModel = CourseViewModel();

  Future<void> _refreshCourses() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Settings'),
            ),
            ListTile(
              title: const Text('Admin Panel'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminPanelScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        onRefresh: _refreshCourses,
        //
        notificationPredicate: (ScrollNotification notification) {
          return notification.depth == 0;
        },
        child: FutureBuilder(
          future: courseViewModel.courses,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("kurslar mavjud emas"),
              );
            }

            final course = snapshot.data;
            return ListView.builder(
              itemCount: course!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(course[index].title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailScreen(
                          course: course[index],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
