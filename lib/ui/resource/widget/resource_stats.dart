import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';

class ResourceStats extends StatelessWidget {
  final Category category;
  final List<String> topics;

  ResourceStats({this.category, this.topics});

  Widget _buildChip(BuildContext context, String name, String avatarUrl) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        avatar: avatarUrl == null
            ? null
            : CircleAvatar(
                backgroundImage: NetworkImage(category.imageUrl),
              ),
        key: ValueKey<String>(name),
        label: Text(
          name,
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> chips =
        topics.map((String topic) => _buildChip(context, topic, null)).toList();
    if (category != null) {
      chips.insert(0, _buildChip(context, category.name, category.imageUrl));
    }
    return SizedBox.fromSize(
      size: const Size.fromHeight(40.0),
      child: ListView.builder(
        itemCount: 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: chips,
          );
        },
      ),
    );
  }
}
