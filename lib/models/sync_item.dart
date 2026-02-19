class SyncItem {
  final int? id;
  final String action; // e.g., 'create_user', 'update_profile'
  final String data; // JSON string of data
  final String timestamp;

  SyncItem({
    this.id,
    required this.action,
    required this.data,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'action': action,
      'data': data,
      'timestamp': timestamp,
    };
  }

  factory SyncItem.fromMap(Map<String, dynamic> map) {
    return SyncItem(
      id: map['id'],
      action: map['action'],
      data: map['data'],
      timestamp: map['timestamp'],
    );
  }
}
