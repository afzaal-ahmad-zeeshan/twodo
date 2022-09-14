import 'package:floor/floor.dart';
import 'package:twodo/models/media.dart';

@dao
abstract class MediaDao {
  @Query('SELECT * FROM media')
  Future<List<Media>> getMedia();

  @Query('SELECT * FROM media WHERE id = :id')
  Future<Media?> findMediaById(int id);

  @Query('SELECT * FROM media WHERE parentId = :id AND mediaParentType = 1')
  Future<Media?> findMediaForCollection(int id);

  @Query('SELECT * FROM media WHERE parentId = :id AND mediaParentType = 0')
  Future<Media?> findMediaForGroup(int id);

  @Query('SELECT * FROM media WHERE parentId = :id AND mediaParentType = 2')
  Future<Media?> findMediaForTask(int id);

  @Query('SELECT * FROM media WHERE parentId = :id AND mediaParentType = 3')
  Future<Media?> findMediaForUser(int id);

  @insert
  Future<int> addMedia(Media media);

  @update
  Future<int> updateMedia(Media media);

  @delete
  Future<int> deleteMedia(Media media);
}
