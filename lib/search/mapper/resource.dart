// Shouldn't be using API mappers but for now this is ok :)
import 'package:learning/api/mapper/author.dart';
import 'package:learning/api/mapper/resource.dart' as ApiResourceMapper;
import 'package:learning/api/mapper/resource_type.dart';
import 'package:learning/data/data.dart';
import 'package:learning/search/mapper/mapper.dart' as IndexMapper;

class ResourceMapper extends IndexMapper.Mapper<LResource> {
  @override
  LResource transformData(dynamic data) {
    return ApiResourceMapper.ResourceMapper(
      AuthorMapper(),
      ResourceTypeMapper(),
    ).transform(data);
  }
}
