import 'package:flutter/material.dart';
import 'package:lesson50/models/course_model.dart';
import 'package:lesson50/viewmodel/course_view_model.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final courseViewModel = CourseViewModel();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _videoUrl = TextEditingController();

  // Future<void> _addCourse() async{
  //   setState(() {
  //     courseViewModel.courses.add(Course(
  //         title: _titleController.text,
  //         description: _descriptionController.text));
  //     _titleController.clear();
  //     _descriptionController.clear();
  //   });
  // }
  void _addCourse() async {
    try {
      courseViewModel.addCourse(
        _titleController.text,
        _descriptionController.text,
        _videoUrl.text,
      );
      if (_titleController.text.isNotEmpty) {
        _titleController.clear();
        _descriptionController.clear();
        _videoUrl.clear();
      }
      setState(() {
        
      });
    } catch (e) {}
  }

  // void _editCourse(int index) {
  //   setState(() {
  //     courseViewModel.courses[index] = Course(
  //         title: _titleController.text,
  //         description: _descriptionController.text);
  //     _titleController.clear();
  //     _descriptionController.clear();
  //   });
  // }

  // void _deleteCourse(int index) {
  //   setState(() {
  //     courseViewModel.courses.removeAt(index);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Course Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descriptionController,
              decoration:
                  const InputDecoration(labelText: 'Course Description'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _videoUrl,
              decoration: const InputDecoration(labelText: 'Video url'),
            ),
          ),
          ElevatedButton(
            onPressed: _addCourse,
            child: const Text('Add Course'),
          ),
          Expanded(
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

                  final courses = snapshot.data;
                  return ListView.builder(
                    itemCount: courses!.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return ListTile(
                        title: Text(course.title),
                        subtitle: Text(course.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _titleController.text = course.title;
                                _descriptionController.text =
                                    course.description;
                                // _editCourse(index);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // _deleteCourse(index);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
