import 'package:uchat/api/payloads/premium_package/ios_check_receipt_response.dart';
import 'package:uchat/api/services/premium_package_service.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/services/premium_package_db.dart';

class PremiumPackageRepository {
  final _premiumPackageService = PremiumPackageService();
  final _premiumPackageDb = PremiumPackageDb.instance;

  Future<List<PremiumPackageCollection>> getAllPremiumPackage({
    bool isForceGetFromServer = false,
  }) async {
    final localPremiumPackage = await _premiumPackageDb.getAll();

    if (localPremiumPackage.isEmpty || isForceGetFromServer) {
      //NOTE.get getAllPremiumPackage from server
      final resultFromServer = await _premiumPackageService.getAllPremiumPackage();

      //NOTE.put in localDB
      resultFromServer.asMap().forEach((int index, PremiumPackageCollection premiumPackageCollection) {
        _premiumPackageDb.putOrUpdate(premiumPackageCollection);
      });

      return resultFromServer;
    } else {
      return localPremiumPackage;
    }
  }

  Future<PremiumPackageCollection> getPremiumPackageById({
    bool isForceGetFromServer = false,
    required String id,
  }) async {
    final localPremiumPackage = await _premiumPackageDb.getById(id: id);

    if (localPremiumPackage == null || isForceGetFromServer) {
      //NOTE.get getPremiumPackageById from server
      final resultFromServer = await _premiumPackageService.getPremiumPackageById(id);

      //NOTE.put in localDB
      _premiumPackageDb.putOrUpdate(resultFromServer);

      return resultFromServer;
    } else {
      return localPremiumPackage;
    }
  }

  Future<PremiumPackageCollection> getPremiumPackageByIdSync({
    bool isForceGetFromServer = false,
    required String id,
  }) async {
    final localPremiumPackage = _premiumPackageDb.getByIdSync(id: id);

    if (localPremiumPackage == null || isForceGetFromServer) {
      //NOTE.get getPremiumPackageById from server
      final resultFromServer = await _premiumPackageService.getPremiumPackageById(id);

      //NOTE.put in localDB
      _premiumPackageDb.putOrUpdate(resultFromServer);

      return resultFromServer;
    } else {
      return localPremiumPackage;
    }
  }

  Future<IosCheckReceiptResponse> checkIOSReceiptSubscription({
    required String receipt,
  }) async {
    final resultFromServer = await _premiumPackageService.checkIOSReceiptSubscription(receipt: receipt);
    return resultFromServer;
  }
}
