import 'package:skye_utils/util/file/file_util.dart';

///the directory type
enum DirectoryType {
  ///the data directory '/data/user/0/<package name>/cache/'
  ApplicationCacheDirectory,

  ///the data directory '/data/user/0/<package name>/files/'
  ApplicationFileDirectory,

  ///the data directory '/data/user/0/<package name>/app_flutter/'
  ApplicationDocumentsDirectory,

  /// the external storage directory '/storage/emulated/0/Android/data/<package name>/cache/'
  ExternalStorageCacheDirectory,

  /// the external storage directory '/storage/emulated/0/Android/data/<package name>/files/'
  ExternalStorageFileDirectory,

  /// the external storage directory '/storage/emulated/0/Android/data/<package name>/files/Music/'
  ExternalStorageMusicDirectory,

  /// the external storage directory '/storage/emulated/0/Android/data/<package name>/files/Pictures/'
  ExternalStoragePictureDirectory,

  /// the external storage directory '/storage/emulated/0/Android/data/<package name>/files/Movies/'
  ExternalStorageMovieDirectory,

  /// the external storage directory '/storage/emulated/0/Android/data/<package name>/files/Download/'
  ExternalStorageDownloadDirectory,

  /// the external storage directory '/storage/emulated/0/Android/data/<package name>/files/Documents/'
  ExternalStorageDocumentDirectory
}

///the extension on the DirectoryType
extension DirectoryTypeExtension on DirectoryType {
  //get the directory
  Future<dynamic> get info => [
        FileUtil.applicationCacheDirectory,
        FileUtil.applicationFileDirectory,
        FileUtil.applicationDocumentsDirectory,
        FileUtil.externalStorageCacheDirectory,
        FileUtil.externalStorageFileDirectory,
        FileUtil.externalStorageMusicDirectory,
        FileUtil.externalStoragePictureDirectory,
        FileUtil.externalStorageMovieDirectory,
        FileUtil.externalStorageDownloadDirectory,
        FileUtil.externalStorageDocumentDirectory,
      ][index];
}
