
class Branch {
  int branchId;
  String? customNo;
  String? arabicName;
  String? arabicDescription;
  String? englishName;
  String? englishDescription;
  String? note;
  String? address;

  Branch({
    required this.branchId,
    this.customNo,
    this.arabicName,
    this.arabicDescription,
    this.englishName,
    this.englishDescription,
    this.note,
    this.address,
  });

  Map<String, dynamic> toJson() => {
    'branchId': branchId,
    'customNo': customNo,
    'arabicName': arabicName,
    'arabicDescription': arabicDescription,
    'englishName': englishName,
    'englishDescription': englishDescription,
    'note': note,
    'address': address,
  };

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    branchId: json['branchId'],
    customNo: json['customNo'],
    arabicName: json['arabicName'],
    arabicDescription: json['arabicDescription'],
    englishName: json['englishName'],
    englishDescription: json['englishDescription'],
    note: json['note'],
    address: json['address'],
  );
}
