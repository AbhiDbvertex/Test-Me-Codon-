class LocationResponse {
  final bool success;
  final List<LocationModel> data;

  LocationResponse({required this.success, required this.data});

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>)
          .map((e) => LocationModel.fromJson(e))
          .toList(),
    );
  }
}

class LocationModel {
  final String id;
  final String name;

  LocationModel({required this.id, required this.name});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    // Assuming the API returns '_id' as the identifier based on history.
    return LocationModel(id: json['_id'] ?? '', name: json['name'] ?? '');
  }
}
