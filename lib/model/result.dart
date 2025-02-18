class Result {
  final String studentId;
  final String branchId;
  final String batchNo;
  final String name;
  final String fatherName;
  final String surname;
  final String emailId;
  final String rollNo;
  final String course;
  final String mobileNo;
  final String profilePic;

  Result({
    required this.studentId,
    required this.branchId,
    required this.batchNo,
    required this.name,
    required this.fatherName,
    required this.surname,
    required this.emailId,
    required this.rollNo,
    required this.course,
    required this.mobileNo,
    required this.profilePic,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      studentId: json['student_id'] ?? '',
      branchId: json['branch_id'] ?? '',
      batchNo: json['batch_no'] ?? '',
      name: json['name'] ?? '',
      fatherName: json['father_name'] ?? '',
      surname: json['surname'] ?? '',
      emailId: json['email_id'] ?? '',
      rollNo: json['roll_no'] ?? '',
      course: json['course'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      profilePic: json['profile_pic'] != null &&
              json['profile_pic'].contains("http")
          ? json['profile_pic']
          : "https://via.placeholder.com/150", // ✅ Default placeholder image
    );
  }
}
