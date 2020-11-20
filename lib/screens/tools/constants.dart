String globalNamaULP;
String globalNamaGardu;
String globalStafLapangan;
DateTime globalWaktuPengukuran;
Map<String, double> globalBebanInduk = {};
Map<String, double> globalBebanPhase = {};
List<Map<String, double>> globalBebanRute = [];
String email;

Map<String, dynamic> globalData = {
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
};
