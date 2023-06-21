class FiltersModel {
  final int status;
  final List<FilterData> data;
  final String message;

  FiltersModel(
      {required this.status, required this.data, required this.message});

  factory FiltersModel.fromjson(Map<dynamic, dynamic> map) {
    return FiltersModel(
      status: map['status'] ?? 0,
      data: List<FilterData>.from(
          (map['data'] ?? []).map((e) => FilterData.fromjson(e))),
      message: map['message'] ?? "",
    );
  }
}

class FilterData {
  final String id;
  final String name;
  final String status;
  bool isSelected;

  FilterData({
    required this.id,
    required this.name,
    required this.status,
    this.isSelected = false,
  });

  factory FilterData.fromjson(Map<dynamic, dynamic> map) {
    return FilterData(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      status: map['status'] ?? "",
    );
  }
}
