abstract class ResourceType {
  String queryString();
}

class CourseResource extends ResourceType {
  @override
  String queryString() {
    return "Course";
  }
}

class MeditationResource extends ResourceType {
  @override
  String queryString() {
    return "Meditation";
  }
}

class BookResource extends ResourceType {
  @override
  String queryString() {
    return "Book";
  }
}
