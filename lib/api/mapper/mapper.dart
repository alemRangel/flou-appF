abstract class Mapper<T> {
  T transform(dynamic data) {
    if (data != null) {
      return transformData(data);
    }
    return null;
  }

  T transformT(dynamic data) {
    if (data != null) {
      return transformTest(data);
    }
    return null;
  }

  T transformData(dynamic data) {
    return null;
  }


  T transformTest(dynamic data) {
    return null;
  }
}
