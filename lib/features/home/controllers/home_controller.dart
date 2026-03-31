import 'package:codon/features/home/home_service.dart';
import 'package:codon/features/home/models/daily_mcq_model.dart';
import 'package:codon/features/subscription/screens/subscription_screen.dart';
import 'package:codon/utills/prefs_service.dart';
import 'package:codon/features/auth/controllers/user_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Navigation
  final currentIndex = 0.obs;
  final showPearl = false.obs;
  // Quiz State
  final selectedAnswer = RxnString();
  final selectedAnswerIndex = RxnInt();
  final isAnswered = false.obs;
  final currentQuestion =
      'What is the scientific theory that explains the origin of the universe?'
          .obs;
  final options = <String>[
    'A. The Big Bang Theory',
    'B. The Big Theory',
    'C. The Bang Theory',
    'D. The A Theory',
  ].obs;

  // User Info
  final userName = 'Bhumika'.obs;
  final moduleCompleted = 0.obs;
  final pearlsCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardStats();
  }

  void togglePearl() {
    showPearl.value = !showPearl.value;
  }

  Future<void> fetchDashboardStats() async {
    try {
      final response = await Get.find<HomeService>().getDashboardStats();
      if (response['success'] == true) {
        final data = response['data'];
        moduleCompleted.value = data['totalCompletedModules'] ?? 0;
        // You could also store completedChapterIds if needed for other features
      }

      // Fetch total codons
      final codonsResponse = await Get.find<HomeService>().countAllTopics();
      if (codonsResponse['success'] == true) {
        pearlsCount.value = codonsResponse['data']['totalTopics'] ?? 0;
      }
    } catch (e) {
      print("Error fetching dashboard stats: $e");
    }
  }

  void selectAnswer(String answer, int index) {
    if (!isAnswered.value) {
      selectedAnswer.value = answer;
      selectedAnswerIndex.value = index;
    }
  }

  void submitDailyMcqAnswer(String mcqId) async {
    if (selectedAnswer.value == null) {
      Get.snackbar(
        'Error',
        'Please select an answer',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Mark as answered to lock the selection
    isAnswered.value = true;

    // Save answer locally
    if (selectedAnswerIndex.value != null) {
      await PrefsService.saveDailyMcqAnswer(mcqId, selectedAnswerIndex.value!);
    }
  }

  void resetDailyMcq() {
    selectedAnswer.value = null;
    selectedAnswerIndex.value = null;
    isAnswered.value = false;
  }


  void submitAnswer() {
    if (selectedAnswer.value == null) {
      Get.snackbar(
        'Error',
        'Please select an answer',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Mock answer submission
    Get.snackbar(
      'Submitted',
      'Answer: ${selectedAnswer.value}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<DailyMcqModel?> getMcqOfTheDay() async {
    try {
      final response = await Get.find<HomeService>().getDailyMcq();
      print("Mcq Data: ${response['data']}");
      if (response['success']) {
        final mcq = DailyMcqModel.fromJson(response['data']);

        // Restore saved answer if exists
        final savedIndex = await PrefsService.getDailyMcqAnswer(mcq.id);
        if (savedIndex != null) {
          selectedAnswerIndex.value = savedIndex;
          selectedAnswer.value = mcq.options[savedIndex].text;
          isAnswered.value = true;
        } else {
          resetDailyMcq();
        }

        return mcq;
      }
    } catch (e) {
      print(e);
    }
  }

  void changeTab(int index) {
    // 0: Home, 1: Codon are always allowed
    if (index == 0 || index == 1) {
      currentIndex.value = index;
      return;
    }

    final user = Get.find<UserController>().userModel.value;
    if (user?.activeSubscription ?? false) {
      currentIndex.value = index;
    } else {
      Get.to(() => const SubscriptionScreen());
    }
  }
}
