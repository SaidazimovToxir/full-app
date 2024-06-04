import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lesson50/models/course_model.dart';

class CourseHttpService {
  Future<List<Course>> getCourses() async {
    Uri url = Uri.parse(
        "https://lesson46-dba31-default-rtdb.firebaseio.com/courses.json");

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Course> loadedCourseData = [];
    if (data != null) {
      data.forEach((key, value) {
        value['id'] = key;

        loadedCourseData.add(Course.fromJson(value));
      });
    }
    // print(loadedCourseData);
    return loadedCourseData;
  }

  Future<Course> addCourse(
      String title, String description, String videoUrl) async {
    Uri url = Uri.parse(
        "https://lesson46-dba31-default-rtdb.firebaseio.com/courses.json");

    Map<String, dynamic> courseData = {
      "title": title,
      "description": description,
      "videoUrl": videoUrl,
    };
    final response = await http.post(
      url,
      body: jsonEncode(courseData),
    );

    final data = jsonDecode(response.body);
    courseData['id'] = data['name'];
    Course newCourse = Course.fromJson(courseData);
    // print(newCourse);
    return newCourse;
  }
}

// void main(List<String> args) {
//   CourseHttpService courseHttpService = CourseHttpService();
//   courseHttpService.addCourse("Test", "test2", "videoUrl");
// }
