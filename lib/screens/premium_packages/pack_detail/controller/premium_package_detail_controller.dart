import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/detail_theme_content_model.dart';
import 'package:uchat/screens/premium_packages/pack_detail/model/premium_package_detail_argument.dart';
import 'package:uchat/screens/premium_packages/store/store_controller.dart';

class PremiumPackageDetailController extends GetxController {
  double get appBarHeight => 200.spMin;

  double get customAppBarHeight => 55.spMin;
  final isInitialing = true.obs;
  final currentPage = 0.0.obs;
  final currentPackageId = ''.obs;
  final currentPackageInfo = Rxn<PremiumPackageCollection>();
  final scrollPageCtl = ScrollController();
  final isShowScrollToTopBtn = false.obs;
  final showCustomAppBar = false.obs;

  SubscriptionController get subscriptionController => SubscriptionController.instance;

  RxList<SubscriptionProductModel> get products => subscriptionController.products;

  final premiumPackages = <PremiumPackageCollection>[
    PremiumPackageCollection(
      id: '1',
      level: 1,
      name: 'Scarlet',
      monthlyPrice: 75,
      yearlyPrice: 720,
      features: FeatureModel(contents: [
        FeatureFlagBase(
          detailThemeContentModel: DetailThemeContentModel(
            title: PremiumPackageLanguageModel(th: 'ทดสอบสการ์เล็ตไอเท็ม1', en: 'Test scarlet item 1'),
            description: PremiumPackageLanguageModel(
              th: 'ทดสอบสการ์เล็ตไอเท็ม1',
              en: 'Test scarlet item 1',
            ),
            order: 1,
            linkUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/How_to_use_icon.svg/40px-How_to_use_icon.svg.png',
          ),
        ),
        FeatureFlagBase(
          detailThemeContentModel: DetailThemeContentModel(
            title: PremiumPackageLanguageModel(th: 'ทดสอบสการ์เล็ตไอเท็ม2', en: 'Test scarlet item 2'),
            description: PremiumPackageLanguageModel(
              th: 'ทดสอบสการ์เล็ตไอเท็ม2',
              en: 'Test scarlet item 2',
            ),
            order: 2,
            linkUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Wikipedia%27s_W.svg/128px-Wikipedia%27s_W.svg.png',
          ),
        ),
      ]),
      packDetailTheme: PackDetailThemeModel(
        bgColor: [
          '#C52E45',
          '#AA213D',
          '#96113A',
        ],
        bgHeaderColor: [
          '#D53159',
          '#EA3253',
          '#F86B71',
          '#FFB4AF',
          // '#FFFFFF',
        ],
        bgWhatIsInclude: '#D83E61',
        bgWhatIsIncludeItem: '#C40B44',
        bgSubscribeBtn: '#E8385F',
        shadowSubscribeBtn: '#BE264E',
        subscribeDescriptionTextColor: '#81515C',
        bgRectMonthly: [
          '#FF577F',
          '#EB3D66',
          '#DF3A6E',
          '#AE42B5',
        ],
        shadowRectMonthly: '#4C226D66',
        decorationItemColorMonthly: '#FFFFFF',
        bgRectYearly: [
          '#FF535E',
          '#FF4662',
          '#EA3253',
          '#D5315A',
        ],
        decorationItemColorYearly: '#FF9988',
      ),
    ),
    PremiumPackageCollection(
      id: '2',
      level: 2,
      name: 'Diamond',
      monthlyPrice: 109,
      yearlyPrice: 1030,
      features: FeatureModel(contents: [
        FeatureFlagBase(
          detailThemeContentModel: DetailThemeContentModel(
            title: PremiumPackageLanguageModel(th: 'ทดสอบไดมอนไอเท็ม1', en: 'Test diamond item 1'),
            description: PremiumPackageLanguageModel(
              th: 'ทดสอบไดมอนไอเท็ม1',
              en: 'Test diamond item 1',
            ),
            order: 1,
            linkUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/How_to_use_icon.svg/40px-How_to_use_icon.svg.png',
          ),
        ),
        FeatureFlagBase(
          detailThemeContentModel: DetailThemeContentModel(
            title: PremiumPackageLanguageModel(th: 'ทดสอบไดมอนไอเท็ม2', en: 'Test diamond item 2'),
            description: PremiumPackageLanguageModel(
              th: 'ทดสอบไดมอนไอเท็ม2',
              en: 'Test diamond item 2',
            ),
            order: 2,
            linkUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Wikipedia%27s_W.svg/128px-Wikipedia%27s_W.svg.png',
          ),
        ),
      ]),
      packDetailTheme: PackDetailThemeModel(
        bgColor: [
          '#59C1FB',
          '#3680D8',
          '#377FD3',
        ],
        bgHeaderColor: [
          '#3491FF',
          '#5ABAFF',
          '#90D7FF',
          '#E3FAFF',
          // '#FFFFFF',
        ],
        bgWhatIsInclude: '#4AB3FF',
        bgWhatIsIncludeItem: '#068BEC',
        bgSubscribeBtn: '#068BEC',
        shadowSubscribeBtn: '#0068B3',
        subscribeDescriptionTextColor: '#5A71A1',
        bgRectMonthly: ['#4A88FF', '#0C4DCD'],
        shadowRectMonthly: '#193D8366',
        decorationItemColorMonthly: '#FFFFFF',
        bgRectYearly: ['#4B92FF', '#BA95E8'],
        decorationItemColorYearly: '#E0ECFF',
      ),
    ),
    PremiumPackageCollection(
      id: '3',
      level: 3,
      name: 'Black',
      monthlyPrice: 149,
      yearlyPrice: 1345,
      features: FeatureModel(contents: [
        FeatureFlagBase(
          detailThemeContentModel: DetailThemeContentModel(
            title: PremiumPackageLanguageModel(th: 'ทดสอบแบล็กไอเท็ม1', en: 'Test black item 1'),
            description: PremiumPackageLanguageModel(
              th: 'ทดสอบแบล็กไอเท็ม1',
              en: 'Test black item 1',
            ),
            order: 1,
            linkUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/How_to_use_icon.svg/40px-How_to_use_icon.svg.png',
          ),
        ),
        FeatureFlagBase(
          detailThemeContentModel: DetailThemeContentModel(
            title: PremiumPackageLanguageModel(th: 'ทดสอบแบล็กไอเท็ม2', en: 'Test black item 2'),
            description: PremiumPackageLanguageModel(
              th: 'ทดสอบแบล็กไอเท็ม2',
              en: 'Test black item 2',
            ),
            order: 2,
            linkUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Wikipedia%27s_W.svg/128px-Wikipedia%27s_W.svg.png',
          ),
        ),
      ]),
      packDetailTheme: PackDetailThemeModel(
        bgColor: ['#24262E', '#1D1E25'],
        bgHeaderColor: ['#1F2128', '#343744', '#5E6272'],
        bgWhatIsInclude: '#2D313F',
        bgWhatIsIncludeItem: '#21232C',
        bgSubscribeBtn: '#2F364D',
        shadowSubscribeBtn: '#121321',
        subscribeDescriptionTextColor: '#4D576C',
        bgRectMonthly: ['#5C6680', '#3F4657'],
        shadowRectMonthly: '#41485A66',
        decorationItemColorMonthly: '#ECEBEB',
        bgRectYearly: ['#2D334D', '#0F0F0F'],
        decorationItemColorYearly: '#22233966',
      ),
    ),
  ].obs;
  PageController? pageController;

  PremiumPackagesStoreController get premiumPackagesStoreController {
    if (!Get.isRegistered<PremiumPackagesStoreController>()) {
      Get.put(PremiumPackagesStoreController());
    }

    return Get.find<PremiumPackagesStoreController>();
  }

  @override
  onInit() async {
    assert(Get.arguments != null, 'Arguments must not be null');
    assert(Get.arguments is PremiumPackageDetailArgument, 'Arguments must be instance of PremiumPackageDetailArgument');
    scrollPageCtl.addListener(pageScrollListener);
    await initData();
    listenPageController();
    super.onInit();
  }

  @override
  onClose() {
    pageController?.dispose();
    scrollPageCtl.removeListener(pageScrollListener);
    super.onClose();
  }

  void pageScrollListener() {
    if (scrollPageCtl.position.atEdge) {
      if (scrollPageCtl.position.pixels > 100 != isShowScrollToTopBtn.value) {
        isShowScrollToTopBtn(scrollPageCtl.position.pixels > 100);
      }
    }

    showCustomAppBar(scrollPageCtl.position.pixels >= (appBarHeight - customAppBarHeight));
  }

  PackDetailThemeModel? get currentPackageTheme => currentPackageInfo.value?.packDetailTheme;

  // Check with in app purchase service as well.
  SubscriptionProductModel? get currentPackageActual => SubscriptionController.instance.products.firstWhereOrNull((e) {
        // iOS
        final c1 = e.productId.toLowerCase().contains(
              currentPackageInfo.value!.name!.toLowerCase(),
            );
        final c2 = e.productId.toLowerCase().contains(
              isMonthlySelected.value == true ? '_monthly' : '1_year',
            );

        // Android
        final c3 = e.productId.toLowerCase().contains(
              currentPackageInfo.value!.name!.toLowerCase(),
            );
        final c4 = e.productId.toLowerCase().contains(
              isMonthlySelected.value == true ? '_1month' : '_1year',
            );

        return (c1 && c2) || (c3 && c4);
      });

  final isMonthlySelected = true.obs;

  bool get isFirstPage => currentPage.value == 0;

  bool get isLastPage => currentPage.value == premiumPackages.length - 1;

  bool get isSubscribed {
    final packageName = UserController.instance.currentUser()?.premiumPackage?.premiumPackageName?.toLowerCase();
    final periodType = UserController.instance.currentUser()?.premiumPackage?.periodType?.value.toLowerCase();
    if (packageName == null || periodType == null) {
      return false;
    }
    final productID = currentPackageActual?.productId.toLowerCase();
    bool tierCheckCondition = userPackageTierLevel() > currentPackageTierLevel();

    return tierCheckCondition || productID?.contains(packageName) == true && productID?.contains(periodType) == true;
  }

  int userPackageTierLevel() {
    final packageName = UserController.instance.currentUser()?.premiumPackage?.premiumPackageName?.toLowerCase();
    final periodType = UserController.instance.currentUser()?.premiumPackage?.periodType?.value.toLowerCase();
    if (packageName == null || periodType == null) {
      return 0;
    }
    return subscriptionController.packageTierLevelCheck(packageName, periodType);
  }

  int currentPackageTierLevel() {
    final comparePackageName = currentPackageInfo.value?.name?.toLowerCase();
    final comparePeriodType = currentPackageActual?.productId.toLowerCase();
    if (comparePackageName == null || comparePeriodType == null) {
      return 0;
    }
    return subscriptionController.packageTierLevelCheck(comparePackageName, comparePeriodType);
  }

  void listenPageController() {
    pageController?.addListener(() {
      currentPage.value = pageController!.page!;
      if ((pageController?.page ?? 0) > premiumPackages.length - 1) {
        currentPackageInfo.value = premiumPackages.firstOrNull;
      } else {
        currentPackageInfo.value = premiumPackages[pageController!.page!.toInt()];
      }
    });
  }

  Future<void> initData() async {
    if (Get.arguments != null) {
      currentPackageId.value = Get.arguments.packageId;
      final packages = premiumPackagesStoreController.premiumPackages.where((element) => element.level != 0).toList();
      packages.sort((a, b) => a.level!.compareTo(b.level!));
      premiumPackages.assignAll(packages);
      if (premiumPackages.isNotEmpty) {
        PremiumPackageCollection? pick =
            premiumPackages.firstWhereOrNull((element) => element.id.toString() == currentPackageId.value.toString());
        currentPackageInfo.value = pick ?? premiumPackages.first;
      }
      pageController = PageController(
        initialPage: premiumPackages.indexWhere((element) => element.id == currentPackageId.value),
      );
      currentPage.value = pageController!.initialPage.toDouble();
      await 1.delay();
      isInitialing.value = false;
    } else {
      Get.back();
    }
  }

  void nextPage() {
    if (pageController?.page != premiumPackages.length - 1) {
      pageController?.nextPage(duration: 500.milliseconds, curve: Curves.easeInOut);
    }
  }

  void previousPage() {
    if (pageController?.page != 0) {
      pageController?.previousPage(duration: 500.milliseconds, curve: Curves.easeInOut);
    }
  }

  Future<void> buySubscription() async {
    try {
      final product = currentPackageActual;
      if (product != null) {
        await subscriptionController.subscribe(product);
      }
    } catch (e, stackTrace) {
      debugPrint('$e');
      debugPrint('$stackTrace');
    }
  }
}
