import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel/src/model/base_controller.dart';
import 'package:flutter_marvel/src/model/fetch_params.dart';
import 'package:flutter_marvel/src/widgets/alert_dialogs/error_dialog.dart';
import 'package:get/state_manager.dart';

class SliverPaginatedGridView extends StatelessWidget {
  const SliverPaginatedGridView({
    super.key,
    required this.controller,
    required this.gridDelegate,
    required this.itemBuilder,
    this.params,
  });

  final BaseController controller;
  final SliverGridDelegate gridDelegate;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final FetchParams? params;

  @override
  Widget build(BuildContext context) {
    fetchData() async {
      final result = await controller.fetchItems(id: params?.id);

      if (result.isLeft() && kDebugMode) {
        if (context.mounted) ErrorDialog.show(context, error: result.getLeft()!);
      }
    }

    return Obx(() {
      return SliverGrid.builder(
        gridDelegate: gridDelegate,
        itemCount: controller.itemsList.length + (controller.hasMore ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index == controller.itemsList.length - 1 && controller.hasMore) {
            fetchData();
          }

          if (index == controller.itemsList.length && controller.hasMore) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return FadeIn(
            child: itemBuilder(context, index),
          );
        },
      );
    });
  }
}
