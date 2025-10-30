import 'package:crypto_app/core/constants/app_color.dart';
import 'package:crypto_app/core/constants/app_spacing.dart';
import 'package:crypto_app/core/constants/placeholders.dart';
import 'package:crypto_app/core/enums/select_item.dart';
import 'package:crypto_app/core/utils/display_format.dart';
import 'package:crypto_app/core/widgets/bottom_selector/bottom_selector.dart';
import 'package:crypto_app/core/widgets/text/text.dart';
import 'package:crypto_app/core/widgets/tooltip/custom_tooltip.dart';
import 'package:crypto_app/feature/dashboard/controllers/crypto_controller.dart';
import 'package:crypto_app/feature/dashboard/view/widgets/coin_shimmer.dart';
import 'package:crypto_app/feature/dashboard/view/widgets/tradingview_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  final CryptoController controller;

  const DashboardView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.small.w,
            vertical: AppSpacing.small.h,
          ),

          child: Column(
            children: [
              // Select Coin
              Obx(() {
                return SizedBox(
                  width: context.width * 0.6,
                  child: BottomSelector(
                    selectId: controller.selectedCoin.value.id,
                    label: 'Coin',
                    sheetTitle: 'Select coin',
                    children: NPlaceholders.cryptoMaster
                        .map(
                          (crypto) => SelectItem(
                            itemName: crypto.name ?? '-',
                            id: crypto.id,
                            icon: crypto.imageUrl,
                          ),
                        )
                        .toList(),
                    onChange: (id) {
                      final coin = NPlaceholders.cryptoMaster.firstWhereOrNull(
                        (crypto) => crypto.id == id,
                      );

                      if (coin != null) {
                        controller.selectedCoinValue = coin;
                      }
                    },
                  ),
                );
              }),
              AppSpacing.h16,

              // Live price
              Obx(() {
                return controller.coinRefresh
                    ? const CoinShimmer()
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NText(
                            text: DisplayFormat.formatUsd(controller.price),
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: controller.priceErrorMsg != null
                                ? AppColors.error
                                : AppColors.white,
                          ),
                          if (controller.priceErrorMsg != null) ...[
                            AppSpacing.w8,
                            CustomTooltip(
                              content: SizedBox(
                                width: context.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    NText(
                                      text: controller.priceErrorMsg!,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    AppSpacing.h8,
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Last Update Time: ',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.white.withValues(
                                                alpha: 0.8,
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                controller.lastUpdateTime ??
                                                '-',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                              color: AppColors.white.withValues(
                                                alpha: 0.6,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      );
              }),
              AppSpacing.h16,
            ],
          ),
        ),

        // Trading Chart
        const Expanded(child: TradingViewChart()),
      ],
    );
  }
}
