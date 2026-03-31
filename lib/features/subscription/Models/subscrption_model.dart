class Subscription {
  final String? planId;
  final String? startDate;
  final String? endDate;
  final bool isActive;
  final int selectedMonths;

  Subscription({
    this.planId,
    this.startDate,
    this.endDate,
    required this.isActive,
    required this.selectedMonths,
  });

  factory Subscription.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Subscription(isActive: false, selectedMonths: 0);
    }
    return Subscription(
      planId: json['plan_id'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      isActive: json['isActive'] ?? false,
      selectedMonths: json['selectedMonths'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan_id': planId,
      'startDate': startDate,
      'endDate': endDate,
      'isActive': isActive,
      'selectedMonths': selectedMonths,
    };
  }
}
