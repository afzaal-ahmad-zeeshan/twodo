import 'package:floor/floor.dart';

enum MediaParent {
  group,
  todo, // collection
  task,
  user,
}

enum MediaType {
  photo,
  video,
  audio,
}

@Entity(tableName: "media")
class Media {
  @primaryKey
  late int id;

  late String filename;
  late int filetype;

  // navigation
  late int mediaParentType;
  late int parentId;
}
