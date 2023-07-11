import 'package:image_picker/image_picker.dart';

class Camera {
  /// the ImagePicker singleton instance
  static final ImagePicker _imagePicker = ImagePicker();

  /// take a photo by the camera , you should request camera permission before using the function
  /// @callback : the callback method
  /// @cameraDevice : the chosen camera
  /// @imageQuality : the compress quality
  static void takePhoto(
    void Function(XFile?) callback, {
    CameraDevice cameraDevice = CameraDevice.rear,
    int? imageQuality,
  }) =>
      _imagePicker
          .pickImage(
              source: ImageSource.camera,
              preferredCameraDevice: cameraDevice,
              imageQuality: imageQuality)
          .then((xFile) => callback.call(xFile));

  /// take a video by the camera , you should request camera permission before using the function
  /// @callback : the callback method
  /// @cameraDevice : the chosen camera
  /// @maxDuration : the max video duration
  static void takeVideo(
    void Function(XFile?) callback, {
    CameraDevice cameraDevice = CameraDevice.rear,
    int? maxDuration,
  }) =>
      _imagePicker
          .pickVideo(
              source: ImageSource.camera,
              preferredCameraDevice: cameraDevice,
              maxDuration: maxDuration == null ? null : Duration(seconds: maxDuration))
          .then((xFile) => callback.call(xFile));

  /// select a photo from the gallery , you should request gallery permission before using the function
  /// @callback : the callback method
  /// @imageQuality : the compress quality
  static void selectPhoto(
    void Function(XFile?) callback, {
    int? imageQuality,
  }) =>
      _imagePicker
          .pickImage(source: ImageSource.gallery, imageQuality: imageQuality)
          .then((xFile) => callback.call(xFile));

  /// select a photo from the gallery , you should request gallery permission before using the function
  /// @callback : the callback method
  /// @imageQuality : the compress quality
  static void selectMultiPhoto(
    void Function(List<XFile>) callback, {
    int? imageQuality,
  }) =>
      _imagePicker
          .pickMultiImage(imageQuality: imageQuality)
          .then((xFiles) => callback.call(xFiles));

  /// select a video from the gallery , you should request gallery permission before using the function
  /// @callback : the callback method
  /// @maxDuration : the max video duration
  static void selectVideo(
    void Function(XFile?) callback, {
    int? maxDuration,
  }) =>
      _imagePicker
          .pickVideo(
              source: ImageSource.gallery,
              maxDuration: maxDuration == null ? null : Duration(seconds: maxDuration))
          .then((xFile) => callback.call(xFile));
}
