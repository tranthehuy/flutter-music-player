import 'package:file_picker/file_picker.dart';

class FileHandler {
  static Future<PlatformFile?> chooseFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = result.files.single;
      return file;
    } else {
      return null;
    }
  }
}