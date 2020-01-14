import 'package:learning/data/data.dart';
import 'package:learning/search/index/index.dart';
import 'package:learning/search/mapper/resource.dart';

class ResourceIndex extends Index<LResource> {
  ResourceIndex() : super('resources', ResourceMapper());
}
