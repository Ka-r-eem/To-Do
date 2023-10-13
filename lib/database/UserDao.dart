import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database/model/user.dart';

class UserDoa {

    static CollectionReference<User> getUserCollection (){
    var db = FirebaseFirestore.instance;
    var usersCollection = db.collection(User.collectionName).withConverter(
        fromFirestore: (snapshot, options) =>
            User.fromFireStore(snapshot.data()),
        toFirestore: (object, options) => object.toFireStore());
    return usersCollection;
  }


    static Future<void> createUser(User user)  {
  var userCollection =  getUserCollection();
  userCollection.add(user);
  var doc = userCollection.doc(user.id);
  return doc.set(user);
  }

  static Future<User?> getUser(String? uid) async {
      var doc = getUserCollection().doc(uid);
      var docSnapshot = await doc.get();
      return docSnapshot.data();
  }
}
