import 'package:lesson50/models/course_model.dart';
import 'package:lesson50/services/course_http_service.dart';

class CourseViewModel {
  CourseHttpService courseHttpService = CourseHttpService();
  List<Course> _courses = [
    Course(
      title: "Course 1",
      description:
          "Occaecat amet qui nostrud ut nulla do. Cillum do ex qui minim proident ipsum sit Lorem incididunt aliquip. Mollit voluptate aliquip commodo aute ad. Consectetur labore officia do mollit adipisicing velit ad incididunt tempor. Nisi sint cillum quis sunt officia quis elit culpa irure adipisicing ipsum mollit. Ullamco velit commodo magna duis adipisicing et commodo minim eiusmod proident ea. Ex sint est tempor pariatur incididunt pariatur fugiat nisi. Est commodo qui ipsum consectetur culpa aute id officia veniam nulla dolor. Excepteur laborum consectetur cillum nostrud tempor sunt. Pariatur culpa amet dolore sit ut consectetur in laborum excepteur elit adipisicing cillum tempor enim.",
      videoUrl:
          "https://videos.pexels.com/video-files/6394054/6394054-hd_1366_684_24fps.mp4",
    ),
    Course(
      title: "Course 2",
      description:
          "Occaecat amet qui nostrud ut nulla do. Cillum do ex qui minim proident ipsum sit Lorem incididunt aliquip. Mollit voluptate aliquip commodo aute ad. Consectetur labore officia do mollit adipisicing velit ad incididunt tempor. Nisi sint cillum quis sunt officia quis elit culpa irure adipisicing ipsum mollit. Ullamco velit commodo magna duis adipisicing et commodo minim eiusmod proident ea. Ex sint est tempor pariatur incididunt pariatur fugiat nisi. Est commodo qui ipsum consectetur culpa aute id officia veniam nulla dolor. Excepteur laborum consectetur cillum nostrud tempor sunt. Pariatur culpa amet dolore sit ut consectetur in laborum excepteur elit adipisicing cillum tempor enim.",
      videoUrl:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    ),
    Course(
      title: "Course 3",
      description:
          "Occaecat amet qui nostrud ut nulla do. Cillum do ex qui minim proident ipsum sit Lorem incididunt aliquip. Mollit voluptate aliquip commodo aute ad. Consectetur labore officia do mollit adipisicing velit ad incididunt tempor. Nisi sint cillum quis sunt officia quis elit culpa irure adipisicing ipsum mollit. Ullamco velit commodo magna duis adipisicing et commodo minim eiusmod proident ea. Ex sint est tempor pariatur incididunt pariatur fugiat nisi. Est commodo qui ipsum consectetur culpa aute id officia veniam nulla dolor. Excepteur laborum consectetur cillum nostrud tempor sunt. Pariatur culpa amet dolore sit ut consectetur in laborum excepteur elit adipisicing cillum tempor enim.",
      videoUrl:
          "https://videos.pexels.com/video-files/1851190/1851190-hd_1280_720_25fps.mp4",
    ),
  ];

  Future<List<Course>> get courses async {
    _courses = await courseHttpService.getCourses();
    return [..._courses];
  }

  Future<void> addCourse(
      String title, String description, String videoUrl) async {
    final newCourse =
        await courseHttpService.addCourse(title, description, videoUrl);

    _courses.add(newCourse);
  }
}
