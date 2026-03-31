import 'package:get/get.dart';

extension SizeRatios on num {
  double toWidthPercent() {
    return Get.width * this;
  }

  double toHeightPercent() {
    return Get.height * this;
  }
}
