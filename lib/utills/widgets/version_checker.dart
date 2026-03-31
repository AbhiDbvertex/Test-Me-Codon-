import 'package:new_version_plus/new_version_plus.dart';

class VersionChecker {
  static Future<bool> isUpdateAvailable() async {
    final newVersion = NewVersionPlus(
      androidId: "com.testmee.app",
    );

    final status = await newVersion.getVersionStatus();
    return status != null && status.canUpdate;
  }
}