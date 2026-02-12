class Patient {
  final String id;
  final String name;
  final String token;
  final String status; // waiting, in-progress, completed
  final String phone;
  final DateTime createdAt;

  Patient({
    required this.id,
    required this.name,
    required this.token,
    required this.status,
    required this.phone,
    required this.createdAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json['id'] as String,
    name: json['name'] as String,
    token: json['token'] as String,
    status: json['status'] as String,
    phone: json['phone'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'token': token,
    'status': status,
    'phone': phone,
    'created_at': createdAt.toIso8601String(),
  };
}
