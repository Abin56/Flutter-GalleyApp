import 'package:hive_flutter/adapters.dart';
part 'db.g.dart';

@HiveType(typeId: 1)
class GalleryModel {
  @HiveField(0)
  final String? image;

  GalleryModel({required this.image});
}

//flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs