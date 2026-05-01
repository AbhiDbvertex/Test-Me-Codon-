import 'package:codon/features/auth/controllers/forgot_password_controller.dart';
import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:codon/features/auth/services/auth_services.dart';
import 'package:codon/features/auth/services/google_sign_in_service.dart';
import 'package:codon/features/auth/services/location_service.dart';
import 'package:codon/features/faculties/controllers/faculties_controller.dart';
import 'package:codon/features/faculties/servies/faculty_service.dart';
import 'package:codon/features/home/controllers/bookmark_controller.dart';
import 'package:codon/features/home/home_service.dart';
import 'package:codon/features/pearls/services/pearl_service.dart';
import 'package:codon/features/qtest/services/qtest_service.dart';

import 'package:codon/features/settings/controllers/edit_profile_controller.dart';
import 'package:codon/features/settings/controllers/change_password_controller.dart';
import 'package:codon/features/settings/services/rating_service.dart';
import 'package:codon/features/settings/services/setting_service.dart';
import 'package:codon/features/splash/services/splash_service.dart';
import 'package:codon/features/subscription/services/subscription_service.dart';
import 'package:codon/features/subscription/controllers/subscription_controller.dart';
import 'package:codon/features/videos/controllers/videos_controller.dart';
import 'package:codon/features/auth/controllers/complete_profile_controller.dart';
import 'package:codon/features/auth/controllers/login_controller.dart';
import 'package:codon/features/auth/controllers/reset_password_controller.dart';
import 'package:codon/features/auth/controllers/signup_controller.dart';
import 'package:codon/features/auth/controllers/verify_otp_controller.dart';
import 'package:codon/features/home/controllers/home_controller.dart';
import 'package:codon/features/pearls/controllers/pearls_controller.dart';
import 'package:codon/features/qtest/controllers/custom_module_controller.dart';
import 'package:codon/features/qtest/controllers/qtest_controller.dart';
import 'package:codon/features/test/controllers/tests_controller.dart';
import 'package:codon/features/settings/controllers/rating_controller.dart';
import 'package:codon/features/settings/controllers/settings_controller.dart';
import 'package:codon/features/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';

import '../features/test/domain/services/test_service.dart';
import '../features/videos/domain/services/video_services.dart';
import 'base_api_client.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    init();
  }

  static void init() {
    Get.put(BaseApiClient(), permanent: true);

    Get.lazyPut(() => UserController(), fenix: true);

    Get.lazyPut(() => SplashController(), fenix: true);
    Get.put<UserController>(UserController());
    Get.put<SplashService>(SplashServiceImpl());
    Get.put<QTestService>(QTestServiceImpl());
    Get.put<HomeService>(HomeServiceImpl());

    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => BookmarkController(), fenix: true);
    Get.lazyPut(() => ForgotPasswordController(), fenix: true);
    Get.lazyPut(() => VerifyOtpController(), fenix: true);
    Get.lazyPut(() => CompleteProfileController(), fenix: true);
    Get.lazyPut(() => ResetPasswordController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => FacultiesController(), fenix: true);
    Get.lazyPut(() => PearlsController(), fenix: true);
    Get.lazyPut(() => QTestController(), fenix: true);
    Get.lazyPut(() => TestsController(), fenix: true);
    Get.lazyPut(() => CustomModuleController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => EditProfileController(), fenix: true);
    Get.lazyPut(() => ChangePasswordController(), fenix: true);
    Get.lazyPut(() => VideosController(), fenix: true);
    Get.lazyPut(() => RatingController(), fenix: true);
    Get.lazyPut(() => SubscriptionController(), fenix: true);
    Get.put<AuthService>(AuthServiceImpl());
    Get.put<GoogleSignInService>(GoogleSignInService());
    Get.put<LocationService>(LocationServiceImpl());
    Get.put<FacultyService>(FacultyServiceImpl());
    Get.put<PearlsService>(PearlServiceImpl());

    Get.put<VideoService>(VideoServiceImpl());
    Get.put<RatingService>(RatingServiceImpl());
    Get.put<TestService>(TestServiceImpl());

    Get.put<SettingService>(SettingServiceImpl());
    Get.put<SubscriptionService>(SubscriptionService());
  }
}
