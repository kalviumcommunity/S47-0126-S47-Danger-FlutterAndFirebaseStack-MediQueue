class QueueToken {
  final String tokenId;
  final String patientName;
  final String phone;
  final String status;
  final DateTime createdAt;

  QueueToken({
    required this.tokenId,
    required this.patientName,
    required this.phone,
    required this.status,
    required this.createdAt,
  });
}
