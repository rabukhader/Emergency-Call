import 'package:emergancy_call/model/emergency.dart';
import 'package:emergancy_call/model/location.dart';

List<Emergency> emergencyList = [
    /* ******************************************************** - Ambulance - ****************************************************************************** */

  Emergency(Location(longitude: 35.22463, latitude: 32.07999), "+972 598 444 101",EmergencyType.ambulance),  //مركز اسعاف  فلسطين
  Emergency(Location(longitude: 35.04885, latitude: 31.76295), "+972 599 222 101",EmergencyType.ambulance), //مركز اسعاف فادي كريم
  Emergency(Location(longitude: 35.28301, latitude: 32.2135), "+972 598 508 011",EmergencyType.ambulance), //مركز اسعاف الكرامة
  Emergency(Location(longitude: 35.17209, latitude: 31.89820), "+97022902212",EmergencyType.ambulance), //مركز طوارئ بيتونيا الطبي التخصصي
  Emergency(Location(longitude: 35.20563, latitude: 31.89948), "+97022982222",EmergencyType.ambulance), // Palestine Medical Complex
  Emergency(Location(longitude: 35.21260, latitude: 31.90683), "+97022406260",EmergencyType.ambulance), //مستشفى الهلال الأحمر الفلسطيني
  Emergency(Location(longitude: 35.16350, latitude: 31.93388), "+97022943200",EmergencyType.ambulance), //Istishari Arab Hospital
  Emergency(Location(longitude: 35.20706, latitude: 31.92495), "+97022962204",EmergencyType.ambulance), //مستشفى اتش كلينك التخصصي
  Emergency(Location(longitude: 35.21482, latitude: 31.91497), "+97022404562",EmergencyType.ambulance), //Al Moustaqbal Hospital
  Emergency(Location(longitude: 35.20977, latitude: 31.92699), "+970592202242",EmergencyType.ambulance), //Health House Center- مركز هيلث هاوس
  Emergency(Location(longitude: 35.20706, latitude: 31.90642), "++97022986420",EmergencyType.ambulance), //Arab Care Hospital
  
  
  /* ******************************************************** - Civil - ****************************************************************************** */
  Emergency(Location(longitude: 35.21380, latitude: 31.90479), "+97022955880",EmergencyType.civil), //مركز دفاع المدني /البيرة
  Emergency(Location(longitude: 35.23133, latitude: 31.85231), " ------ ",EmergencyType.civil), //مركز اسناد الوسط (الدفاع المدني )
  Emergency(Location(longitude: 35.23646, latitude: 31.84738), "+972 562 505 677",EmergencyType.civil), //مديرية الدفاع المدني / محافظة القدس
  Emergency(Location(longitude: 35.29719, latitude: 31.95936), "--------",EmergencyType.civil), //مركز دفاع المدني دير جرير 
  Emergency(Location(longitude: 34.97347, latitude: 32.19138), "------",EmergencyType.civil), //Fire Station قلقيلية


  /* ******************************************************** - Police - ****************************************************************************** */
    Emergency(Location(longitude: 35.29413, latitude: 32.46307), "+97042501301", EmergencyType.police), //مركز شرطة جنين
    Emergency(Location(longitude: 35.46805, latitude: 31.86361), "+97092940440", EmergencyType.police), //مركز شرطة مدينه أريحا
    Emergency(Location(longitude: 35.17624, latitude: 32.08254), "+97092515101", EmergencyType.police), //مركز شرطة مدينة سلفيت
    Emergency(Location(longitude: 35.28939, latitude: 32.42274), "+97042522515", EmergencyType.police), //Qabatiya police station
    Emergency(Location(longitude: 35.19427, latitude: 31.97259), "---------", EmergencyType.police), //مخفر شرطة بيرزيت
    Emergency(Location(longitude: 35.26350, latitude: 32.22837), "", EmergencyType.police), //شرطة نابلس



];
