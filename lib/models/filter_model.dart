class FilterModel {
  String? male;
  String? female;
  String? location;
  String? category;
  String? startSal;
  String? endSal;

  FilterModel({
    this.male,
    this.female,
    this.location,
    this.category,
    this.startSal,
    this.endSal,
  });

  static FilterModel fromList(Map<String,dynamic> data) {
    var json = data;
    return FilterModel(
      male: json['male'],
      female: json['female'],
      location: json['location'],
      category: json['category'],
      startSal: json['startSal'],
      endSal: json['endSal'],
    );
  }
}
