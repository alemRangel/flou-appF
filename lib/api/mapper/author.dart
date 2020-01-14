import 'package:learning/api/mapper/mapper.dart';
import 'package:learning/data/data.dart';

class AuthorMapper extends Mapper<Author> {
  @override
  Author transformData(dynamic json) {
    return Author(
      name: json['name'],
    );
  }
  @override
  Author transformTest(dynamic json) {
    return Author.fromJson(json);
  }
}
