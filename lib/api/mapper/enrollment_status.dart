import 'package:learning/api/mapper/mapper.dart';
import 'package:learning/data/data.dart';

class EnrollmentStatusMapper extends Mapper<EnrollmentStatus> {
  @override
  EnrollmentStatus transformData(dynamic data) {
    switch (data) {
      case 'InProgress':
        return EnrollmentStatus.inProgress;
      case 'Finished':
        return EnrollmentStatus.finished;
      default:
        return EnrollmentStatus.inLibrary;
    }
  }

}
