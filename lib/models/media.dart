import 'package:floor/floor.dart';

enum MediaType {
  photo,
  video,
  audio,
}

class Media {
  @primaryKey
  late int id;

  late String filename;
  late int filetype;
}
