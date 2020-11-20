import 'package:beban_trafo/screens/tools/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  CollectionReference productCollection;

  DatabaseServices({String name}) {
    FirebaseFirestore.instance.settings = Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
    this.productCollection = FirebaseFirestore.instance.collection(name);
  }

  Future<void> createAndUpdateProduct(String id,
      {String name, int price}) async {
    await productCollection.doc(id).set({
      "ulp": globalNamaULP,
      "gardu": globalNamaGardu,
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
  }

  Future<QuerySnapshot> getData() async {
    return productCollection.orderBy("waktuPengukuran").get();
  }

  Future<void> deleteData(String id) async {
    await productCollection.doc(id.toString()).delete();
  }
}
