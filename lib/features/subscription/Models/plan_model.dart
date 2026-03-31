class PlanModel {
  final String id;
  final String name;
  final List<String> features;
  final List<Pricing> pricing;
  final bool isActive;

  PlanModel({
    required this.id,
    required this.name,
    required this.features,
    required this.pricing,
    required this.isActive,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      features: List<String>.from(json['features'] ?? []),
      pricing: (json['pricing'] as List)
          .map((i) => Pricing.fromJson(i))
          .toList(),
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'features': features,
      'pricing': pricing.map((i) => i.toJson()).toList(),
      'isActive': isActive,
    };
  }
}

class Pricing {
  final String durationType;
  final int months;
  final int extraMonths;
  final int totalMonths;
  final int days;
  final double price;
  final double perDay;
  final String planLabel;
  final String discountLabel;

  Pricing({
    required this.durationType,
    required this.months,
    required this.extraMonths,
    required this.totalMonths,
    required this.days,
    required this.price,
    required this.perDay,
    required this.planLabel,
    required this.discountLabel,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      durationType: json['durationType'] ?? '',
      months: json['months'] ?? 0,
      extraMonths: json['extraMonths'] ?? 0,
      totalMonths: json['totalMonths'] ?? 0,
      days: json['days'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      perDay: (json['perDay'] ?? 0).toDouble(),
      planLabel: json['planLabel'] ?? '',
      discountLabel: json['discountLabel'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'durationType': durationType,
      'months': months,
      'extraMonths': extraMonths,
      'totalMonths': totalMonths,
      'days': days,
      'price': price,
      'perDay': perDay,
      'planLabel': planLabel,
      'discountLabel': discountLabel,
    };
  }
}
