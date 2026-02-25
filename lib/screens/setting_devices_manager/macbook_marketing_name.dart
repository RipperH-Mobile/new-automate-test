import 'package:get/get.dart';

String getMacMarketingName(String modelName) {
  switch (modelName) {
    /// [Macbook Pro]
    // Mac 15
    case 'Mac15,3':
      return 'MacBook Pro M3 (14-inch)';
    case 'Mac15,6':
      return 'MacBook Pro M3 Pro (14-inch)';
    case 'Mac15,8':
    case 'Mac15,10':
      return 'MacBook Pro M3 Max (14-inch)';
    case 'Mac15,7':
      return 'MacBook Pro M3 Pro (16-inch)';
    case 'Mac15,9':
    case 'Mac15,11':
      return 'MacBook Pro M3 Max (16-inch)';
    // Mac 14
    case 'Mac14,5':
      return 'MacBook Pro M2 Max (14-inch)';
    case 'Mac14,9':
      return 'MacBook Pro M2 Pro (14-inch)';
    case 'Mac14,6':
      return 'MacBook Pro M2 Max (16-inch)';
    case 'Mac14,10':
      return 'MacBook Pro M2 Pro (16-inch)';
    case 'Mac14,7':
      return 'MacBook Pro M2 (13-inch)';
    // MacBookPro 18
    case 'MacBookPro18,3':
      return 'MacBook Pro M1 Pro (14-inch)';
    case 'MacBookPro18,4':
      return 'MacBook Pro M1 Max (14-inch)';
    case 'MacBookPro18,1':
      return 'MacBook Pro M1 Pro (16-inch)';
    case 'MacBookPro18,2':
      return 'MacBook Pro M1 Max (16-inch)';
    // MacBookPro 17
    case 'MacBookPro17,1':
      return 'MacBook Pro M1 Max (13-inch)';
    // MacBookPro 16, 15, 14, 13, 12, 11, 10, 9, 8
    case 'MacBookPro16,3':
    case 'MacBookPro16,2':
    case 'MacBookPro15,4':
    case 'MacBookPro15,2':
    case 'MacBookPro14,1':
    case 'MacBookPro14,2':
    case 'MacBookPro13,1':
    case 'MacBookPro12,1':
    case 'MacBookPro11,1':
    case 'MacBookPro10,2':
    case 'MacBookPro9,2':
    case 'MacBookPro8,1':
      return 'MacBook Pro (Core i5, i7) (13-inch)';
    case 'MacBookPro16,1':
    case 'MacBookPro16,4':
      return 'MacBook Pro (Core i7, i9) (16-inch)';
    // MacBookPro 15
    case 'MacBookPro15,1':
    case 'MacBookPro15,3':
      return 'MacBook Pro (Core i7, i9) (15-inch)';
    // MacBookPro 14, 13, 11, 10, 9, 8
    case 'MacBookPro14,3':
    case 'MacBookPro13,3':
    case 'MacBookPro11,4':
    case 'MacBookPro11,5':
    case 'MacBookPro11,2':
    case 'MacBookPro11,3':
    case 'MacBookPro10,1':
    case 'MacBookPro9,1':
    case 'MacBookPro8,2':
      return 'MacBook Pro Core i7 (15-inch)';
    // MacBookPro 13
    case 'MacBookPro13,2':
      return 'MacBook Pro Core i5, i7 (13-inch)';
    // MacBookPro 8
    case 'MacBookPro8,3':
      return 'MacBook Pro Core i7 (17-inch)';
    // MacBookPro 7, 5
    case 'MacBookPro7,1':
    case 'MacBookPro5,5':
      return 'MacBook Pro Core 2 Duo (13-inch)';
    // MacBookPro 6
    case 'MacBookPro6,1':
      return 'MacBook Pro (Core i5, i7) (17-inch)';
    case 'MacBookPro6,2':
      return 'MacBook Pro (Core i5, i7) (15-inch)';
    // MacBookPro 5, 2
    case 'MacBookPro5,2':
    case 'MacBookPro2,1':
      return 'MacBook Pro Core 2 Duo (17-inch)';
    case 'MacBookPro5,1':
    case 'MacBookPro5,3':
    case 'MacBookPro5,4':
    case 'MacBookPro2,2':
      return 'MacBook Pro Core 2 Duo (15-inch)';
    // MacBookPro 4, 3
    case 'MacBookPro4,1':
    case 'MacBookPro3,1':
      return 'MacBook Pro Core 2 Duo (15, 17-inch)';
    // MacBookPro 1
    case 'MacBookPro1,2':
      return 'MacBook Pro Core Duo (17-inch)';
    case 'MacBookPro1,1':
      return 'MacBook Pro Core Duo (15-inch)';

    /// [Macbook Air]
    // Mac 15
    case 'Mac15,13':
      return 'MacBook Air M3 (15-inch)';
    case 'Mac15,12':
      return 'MacBook Air M3 (13-inch)';
    // Mac 14
    case 'Mac14,15':
      return 'MacBook Air M2 (15-inch)';
    case 'Mac14,2':
      return 'MacBook Air M2 (13-inch)';
    // MacBookAir 10
    case 'MacBookAir10,1':
      return 'MacBook Air M1 (13-inch)';
    // MacBookAir 9
    case 'MacBookAir9,1':
      return 'MacBook Air (Core i3, i5, i7) (13-inch)';
    // MacBookAir 8
    case 'MacBookAir8,2':
    case 'MacBookAir8,1':
      return 'MacBook Air Core i5 (13-inch)';
    // MacBookAir 7, 6, 5, 4
    case 'MacBookAir7,2':
    case 'MacBookAir6,2':
    case 'MacBookAir5,2':
    case 'MacBookAir4,2':
      return 'MacBook Air (Core i5, i7) (13-inch)';
    case 'MacBookAir7,1':
    case 'MacBookAir6,1':
    case 'MacBookAir5,1':
    case 'MacBookAir4,1':
      return 'MacBook Air (Core i5, i7) (11-inch)';
    // MacBookAir 3, 2, 1
    case 'MacBookAir3,2':
    case 'MacBookAir2,1':
    case 'MacBookAir1,1':
      return 'MacBook Air Core 2 Duo (13-inch)';
    case 'MacBookAir3,1':
      return 'MacBook Air Core 2 Duo (11-inch)';

    /// [Macbook]
    // MacBook 10
    case 'MacBook10,1':
      return 'MacBook (Core i5, i7, Core m3) (12-inch)';
    // MacBook 9
    case 'MacBook9,1':
      return 'MacBook (Core m3, m5, m7) (12-inch)';
    // MacBook 8
    case 'MacBook8,1':
      return 'MacBook Core M (12-inch)';
    // MacBook 7, 6, 5, 4, 3, 2
    case 'MacBook7,1':
    case 'MacBook6,1':
    case 'MacBook5,1':
    case 'MacBook5,2':
    case 'MacBook4,1':
    case 'MacBook3,1':
    case 'MacBook2,1':
      return 'MacBook Core 2 Duo (13-inch)';
    // MacBook 1
    case 'MacBook1,1':
      return 'MacBook Core Duo (13-inch)';

    /// [Mac Studio]
    // Mac 13
    case 'Mac13,2':
      return 'Mac Studio M1 Ultra';
    case 'Mac13,1':
      return 'Mac Studio M1 Max';

    /// [Mac Pro]
    // MacPro 7
    case 'MacPro7,1':
      return 'Mac Pro (28, 24, 16, 12, Eight Core)';
    // MacPro 6, 5
    case 'MacPro6,1':
    case 'MacPro5,1':
      return 'Mac Pro (Quad, Six, Eight, Twelve Core)';
    // MacPro 4, 3
    case 'MacPro4,1':
    case 'MacPro3,1':
      return 'Mac Pro (Quad, Eight Core)';
    // MacPro 2
    case 'MacPro2,1':
      return 'Mac Pro Eight Core';
    // MacPro 1
    case 'MacPro1,1*':
      return 'Mac Pro Quad Core';

    /// [Mac Mini]
    // ADP 3
    case 'ADP3,2':
      return 'Mac mini DTK';
    // Mac 14
    case 'Mac14,12':
      return 'Mac mini M2 Pro';
    case 'Mac14,3':
      return 'Mac mini M2';
    // Macmini 9
    case 'Macmini9,1':
      return 'Mac mini M1';
    // Macmini 8
    case 'Macmini8,1':
      return 'Mac mini (Core i3, i5, i7)';
    // Macmini 7, 5
    case 'Macmini7,1':
    case 'Macmini5,2':
      return 'Mac mini (Core i5, i7)';
    // Macmini 6, 5
    case 'Macmini6,2':
    case 'Macmini5,3':
      return 'Mac mini Core i7';
    case 'Macmini6,1':
    case 'Macmini5,1':
      return 'Mac mini Core i5';
    // Macmini 4, 3, 2
    case 'Macmini4,1':
    case 'Macmini3,1':
    case 'Macmini2,1':
      return 'Mac mini Core 2 Duo';
    // Macmini 1
    case 'Macmini1,1':
      return 'Mac mini Core Duo';

    /// [iMac Pro]
    // iMacPro 1
    case 'iMacPro1,1':
      return 'iMac Pro (27-inch)';

    /// [iMac]
    // iMac 21
    case 'iMac21,1':
    case 'iMac21,2':
      return 'iMac M1 (24-inch)';
    // iMac 20
    case 'iMac20,1':
      return 'iMac (Core i5, i7, i9) (27-inch)';
    case 'iMac20,2':
      return 'iMac (Core i7, i9) (27-inch)';
    // iMac 19, 12
    case 'iMac19,1':
      return 'iMac (Core i5, i9) (27-inch)';
    case 'iMac19,2':
      return 'iMac (Core i3, i5, i7) (21.5-inch)';
    // iMac 18, 17, 16, 15, 14, 13, 12, 11
    case 'iMac18,1':
    case 'iMac16,1':
    case 'iMac14,1':
    case 'iMac14,4':
      return 'iMac Core i5 (21.5-inch)';
    case 'iMac18,2':
    case 'iMac16,2':
    case 'iMac14,3':
      return 'iMac (Core i5, i7) (21.5-inch)';
    case 'iMac18,3':
    case 'iMac17,1':
    case 'iMac15,1':
    case 'iMac14,2':
    case 'iMac13,2':
    case 'iMac12,2':
    case 'iMac11,1':
      return 'iMac (Core i5, i7) (27-inch)';
    // iMac 13, 12
    case 'iMac13,1':
    case 'iMac12,1':
      return 'iMac (Core i3, i5, i7) (21.5-inch)';
    // iMac 11
    case 'iMac11,3':
      return 'iMac (Core i3, i5, i7) (27-inch)';
    case 'iMac11,2':
      return 'iMac (Core i3, i5) (21.5-inch)';
    // iMac 10
    case 'iMac10,1':
      return 'iMac Core 2 Duo (21, 27-inch)';
    // iMac 9, 8
    case 'iMac9,1':
    case 'iMac8,1':
      return 'iMac Core 2 Duo (20, 24-inch)';
    // iMac 7
    case 'iMac7,1':
      return 'iMac (Core 2 Duo, Extreme) (20, 24-inch)';
    // iMac 6
    case 'iMac6,1':
      return 'iMac Core 2 Duo (24-inch)';
    // iMac 5
    case 'iMac5,1':
      return 'iMac Core 2 Duo (17, 20-inch)';
    case 'iMac5,2':
      return 'iMac Core 2 Duo (17-inch)';
    // iMac 4
    case 'iMac4,2':
      return 'iMac Core Duo (17-inch)';
    case 'iMac4,1':
      return 'iMac Core Duo (17, 20-inch)';
  }

  return 'UNKNOWN'.tr;
}
