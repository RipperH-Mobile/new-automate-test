import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/coin/presentation/controllers/coin_store_controller.dart';
import 'package:uchat/features/coin/presentation/screens/coin_store/widgets/coin_store_item.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class CoinStoreItemList extends StatelessWidget {
  const CoinStoreItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinStoreController>(
      id: CoinStoreIds.coinItemList,
      builder: (ctl) {
        if (ctl.isLoadingCoinPackages) {
          return Column(
            spacing: AppSpace.space4,
            children: List.generate(
              9,
              (index) => ShimmerLoading(
                enable: true,
                child: SizedBox(
                  height: 32.h,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        width: 200.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppRadius.roundedLg),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 80.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppRadius.roundedLg),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Column(
          spacing: AppSpace.space4,
          children: List.generate(
            ctl.coinPackages.length,
            (index) => CoinStoreItem(
              onTap: () => ctl.buyCoinPackage(ctl.coinPackages[index]),
              coinPackage: ctl.coinPackages[index],
            ),
          ),
        );
      },
    );
  }
}
