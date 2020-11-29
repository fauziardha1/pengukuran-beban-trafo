import 'dart:convert';

import 'package:beban_trafo/screens/tools/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  CollectionReference productCollection;
  CollectionReference historyCollection;
  List<String> documentToDelete = [];

  DatabaseServices({String name}) {
    if (!FirebaseFirestore.instance.settings.persistenceEnabled) {
      FirebaseFirestore.instance.settings = Settings(
          persistenceEnabled: true,
          cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
    }

    this.productCollection = FirebaseFirestore.instance.collection(name);
    this.historyCollection = FirebaseFirestore.instance.collection("History");
  }

  Future<void> createAndUpdateProduct(String id,
      {String name, int price}) async {
    await productCollection.doc(id).set({
      "ulp": globalNamaULP,
      "gardu": globalNamaGardu,
      "stafEmail": globalEmail,
      "staf Lapangan": globalStafLapangan,
      "timestamp": globalWaktuPengukuran.toString(),
      "waktu Pengukuran": {
        "day": globalWaktuPengukuran.day,
        "month": globalWaktuPengukuran.month,
        "year": globalWaktuPengukuran.year,
        "milliseconds": globalWaktuPengukuran.millisecondsSinceEpoch,
      },
      "hasil Pengukuran": {
        "bebanInduk": globalBebanInduk,
        "bebanRute": globalBebanRute,
        "bebanPhase": globalBebanPhase
      }
    });

    await historyCollection.doc(globalWaktuPengukuran.toString()).set({
      "ulp": globalNamaULP,
      "gardu": globalNamaGardu,
      "stafEmail": globalEmail,
      "staf Lapangan": globalStafLapangan,
      "timestamp": globalWaktuPengukuran.toString(),
      "waktu Pengukuran": {
        "day": globalWaktuPengukuran.day,
        "month": globalWaktuPengukuran.month,
        "year": globalWaktuPengukuran.year,
        "milliseconds": globalWaktuPengukuran.millisecondsSinceEpoch,
      },
      "hasil Pengukuran": {
        "bebanInduk": globalBebanInduk,
        "bebanRute": globalBebanRute,
        "bebanPhase": globalBebanPhase
      }
    });

    globalBebanRute = [];
  }

  Future<QuerySnapshot> getData() async {
    return productCollection.orderBy("waktuPengukuran").get();
  }

  Future<List<String>> getHistory() async {
    print("Staf Lapangan : $globalEmail");
    // mengembalikan kumpulan record tanggal yang berisi maps data dengan index histroy

    var temp = await historyCollection
        .where("stafEmail", isEqualTo: globalEmail)
        .get();

    List<String> history = [];
    List<String> documentID = [];

    temp.docs.forEach((element) {
      if (documentID.indexOf(element.id) <= 0) {
        documentID.add(element.id);
      }
      history.insert(0, json.encode(element.data()));
    });
    print("documentID : $documentID");

    documentToDelete = documentID;

    return history;
  }

  Future<DocumentSnapshot> getDocumentsByEmail({String email}) async {
    var temp = await historyCollection.doc(email).get();
    return temp;
  }

  Future<void> deleteData(String id) async {
    await productCollection.doc(id.toString()).delete();
  }

  Future<void> deleteUserHistory({String email}) async {
    for (var documentID in documentToDelete) {
      await historyCollection.doc(documentID).delete();
    }
  }

  Future<void> deleteAHistory({String id}) async {
    await historyCollection.doc(id).delete();
  }
}
