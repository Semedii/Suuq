import 'package:firebase_storage/firebase_storage.dart';

class ImageDataService {
  final storageRef = FirebaseStorage.instance.ref();


  Future<String> retrieveImageUrl(id) async {
    final imageRef = storageRef.child("images/products/$id.jpg");
    var url = await imageRef.getDownloadURL();
    return url;
  }
}
