import 'dart:io';

import 'package:path_provider/path_provider.dart';

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

///the class_extension on the DirectoryType
extension DirectoryTypeExtension on DirectoryType {
  //get the directory
  Future<dynamic> get info => [
        _DirectoryInfo.applicationCacheDirectory,
        _DirectoryInfo.applicationFileDirectory,
        _DirectoryInfo.applicationDocumentsDirectory,
        _DirectoryInfo.externalStorageCacheDirectory,
        _DirectoryInfo.externalStorageFileDirectory,
        _DirectoryInfo.externalStorageMusicDirectory,
        _DirectoryInfo.externalStoragePictureDirectory,
        _DirectoryInfo.externalStorageMovieDirectory,
        _DirectoryInfo.externalStorageDownloadDirectory,
        _DirectoryInfo.externalStorageDocumentDirectory,
      ][index];
}

/// the directory info
class _DirectoryInfo {
  static final Future<Directory> applicationCacheDirectory = getTemporaryDirectory();
  static final Future<Directory> applicationFileDirectory = getApplicationSupportDirectory();
  static final Future<Directory> applicationDocumentsDirectory = getApplicationDocumentsDirectory();
  static final Future<List<Directory>?> externalStorageCacheDirectory =
      getExternalCacheDirectories();
  static final Future<Directory?> externalStorageFileDirectory = getExternalStorageDirectory();
  static final Future<List<Directory>?> externalStorageMusicDirectory =
      getExternalStorageDirectories(type: StorageDirectory.music);
  static final Future<List<Directory>?> externalStoragePictureDirectory =
      getExternalStorageDirectories(type: StorageDirectory.pictures);
  static final Future<List<Directory>?> externalStorageMovieDirectory =
      getExternalStorageDirectories(type: StorageDirectory.movies);
  static final Future<List<Directory>?> externalStorageDownloadDirectory =
      getExternalStorageDirectories(type: StorageDirectory.downloads);
  static final Future<List<Directory>?> externalStorageDocumentDirectory =
      getExternalStorageDirectories(type: StorageDirectory.documents);
}
