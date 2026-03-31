// const String baseUrl = "https://coden.graphicsvolume.com";
//const String baseUrl = "https://api.codon.graphicsvolume.com";
// const String baseUrl = "https://api.codonneetug.com";
const String baseUrl = "https://api.codonneetug.com";
// Auth
const String emailLoginUrl = "$baseUrl/api/users/login";
const String registerUrl = "$baseUrl/api/users/register";
const String forgotPasswordUrl = "$baseUrl/api/users/forgot-password";

const String resetPasswordUrl = "$baseUrl/api/users/change-password";
const String logoutUrl = "$baseUrl/api/users/logout";
const String verifyUserUrl = "$baseUrl/api/users/verify-user";
const String verifyEmailUrl = "$baseUrl/api/users/verify-email";
const String profileUrl = "$baseUrl/api/users/profile";
const String resendOtpUrl = "$baseUrl/api/users/resend-otp";
const String googleAuthUrl = "$baseUrl/api/users/google";

const String promoCode = "$baseUrl/api/users/promo-apply";


const String authMeUrl = "$baseUrl/api/users/auth-me";

// Home
const String homeUrl = "/api/v1/home";

// Pearls
const String pearlsUrl = "/api/v1/pearls";
const String pearlDetailUrl = "/api/v1/pearls/";
const String getCourseUrl = "/api/v1/pearls/course";
const String getSubjectsUrl = "/api/v1/pearls/subjects/";
const String getSubSubjectsUrl = "$baseUrl/api/users/sub-subjects";
const String getChapterUrl = "$baseUrl/api/users/chapters/subsubject/";
const String getChapterDetailUrl = "$baseUrl/api/users/details/";

// QTest
const String getQTestMcqsUrl = "$baseUrl/api/users/get-mcqs";
const String getQTestsUrl = "$baseUrl/api/tests/qtest";
const String getChapterByTopicUrl = "$baseUrl/api/users/chapters-by-topic";
const String generateCustomTestUrl = "$baseUrl/api/users/generate-custom-test";
const String getAllTagsUrl = "$baseUrl/api/users/alltag";
const String submitQTestUrl = "$baseUrl/api/tests/submit-Qtest";
const String customTestHistoryUrl = "$baseUrl/api/users/custom-test-history";
const String getCustomTestDetailsUrl = "$baseUrl/api/users/custom-test";
const String saveCustomAnswerUrl = "$baseUrl/api/users/save-custom-answer";
const String submitCustomTestUrl = "$baseUrl/api/users/submit-custom-test";
// Tests
const String getTestUrl = "$baseUrl/api/tests";
const String getTestId="$baseUrl/api/tests/preview";
const String getExamTestsUrl = "$baseUrl/api/tests/exam";

// const String getQuestionUrl = "$baseUrl/api/tests/attempt/{ATTEMPT_ID}/question";
// const String answerTestUrl = "$baseUrl/api/tests/attempt/{ATTEMPT_ID}/answer";
// const String submitTestUrl = "$baseUrl/api/tests/attempt/{ATTEMPT_ID}/submit";
const String attemptTestUrl = "$baseUrl/api/tests/attempt/";

// const String attemptTestUrl = "$baseUrl/api/tests/test-result/{USER_ID}/{TEST_ID}";
const String resultTestUrl = "$baseUrl/api/tests/test-result/";

// const String reviewTestUrl = "$baseUrl/api/tests/test-review/{USER_ID}/{TEST_ID}";
const String reviewTestUrl = "$baseUrl/api/tests/test-review/";

// Settings
const String settingsUrl = "/api/v1/settings";
const String editProfileUrl = "$baseUrl/api/users/profile";
const String changePasswordUrl = "/api/v1/settings/change-password";
const String aboutUsUrl = "$baseUrl/api/users/about-us";
const String privacyPolicyUrl = "$baseUrl/api/users/privacy-policy";
const String faveriteUrl = "/api/v1/settings/faverite";
const String historyUrl = "/api/v1/settings/history";
const String termsConditionsUrl = "$baseUrl/api/users/terms-conditions";

// Videos
const String getSubjectUrl = "$baseUrl/api/users/subjects";
const String getSubSubjectUrl = "$baseUrl/api/users/sub-subjects";
const String getTopicUrl = "$baseUrl/api/users/topics/chapter/";
const String getTopicDetailsUrl = "$baseUrl/api/users/topic-details/";
const String getTopicVideosUrl = "$baseUrl/api/users/topic-videos";
const String getChapterVideosUrl = "$baseUrl/api/users/chapter";
const String updateProgressUrl = "$baseUrl/api/users/update-progress";

// Rating
const String ratingUrl = "$baseUrl/api/users/rating";

///Home
const String dailyMcqUrl = "$baseUrl/api/users/daily-mcq";
const String dashboardStatsUrl = "$baseUrl/api/users/dashboard-stats";
const String countAllTopicsUrl = "$baseUrl/api/users/count-all-topics";
const String toggleBookmarkUrl = "$baseUrl/api/users/toggle-bookmark";
const String removeBookmarkUrl = '$baseUrl/api/users/remove-bookmark';
//locations
const String getStatesUrl = "$baseUrl/api/location/active-list";
const String getCitiesUrl = "$baseUrl/api/location/city?stateId=";
const String getCoursesUrl = "$baseUrl/api/users/list";
const String listBookmarksUrl = "$baseUrl/api/users/get-my-bookmarks";

// Faculties
const String getFacultiesUrl = "$baseUrl/api/faculty/list";

// Plans
const String getPlansUrl = "$baseUrl/api/plans/plan";
const String createOrderUrl = "$baseUrl/api/payment/create-order";
const String verifyPaymentUrl = "$baseUrl/api/payment/verify-payment";
