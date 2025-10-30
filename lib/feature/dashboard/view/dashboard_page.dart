import 'package:crypto_app/feature/dashboard/controllers/crypto_controller.dart';
import 'package:crypto_app/feature/dashboard/view/dashboard_view.dart';
import 'package:crypto_app/feature/dashboard/view/widgets/dashboard_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<CryptoController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.isInitLoading
              ? const DashboardShimmer()
              : DashboardView(controller: controller),
        ),
      ),
    );
  }
}
