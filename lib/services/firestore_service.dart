import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirestoreService() {
    _enablePersistence();
  }

  Future<void> _enablePersistence() async {
    // Firestore persistence is enabled by default on Android and iOS.
    // However, we can configure cache settings here if needed.
    _db.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  // Generic method to add data
  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).add(data);
    } catch (e) {
      // Handle error or log it
      print('Error adding document: $e');
      rethrow;
    }
  }

  // Generic method to update data
  Future<void> updateDocument(String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).doc(docId).update(data);
    } catch (e) {
      print('Error updating document: $e');
      rethrow;
    }
  }

  // Generic method to get a stream of data (Real-time updates)
  Stream<QuerySnapshot> getCollectionStream(String collection) {
    return _db.collection(collection).snapshots();
  }

  // Get data once (Offline first strategy usually relies on streams for UI, but sometimes we need a single fetch)
  // Source.cache will try to fetch from cache first.
  Future<DocumentSnapshot> getDocument(String collection, String docId, {Source source = Source.defaultSource}) async {
      return await _db.collection(collection).doc(docId).get(GetOptions(source: source));
  }
}
