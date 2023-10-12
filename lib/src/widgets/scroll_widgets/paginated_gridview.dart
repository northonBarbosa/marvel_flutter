import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel/src/model/base_controller.dart';
import 'package:flutter_marvel/src/model/fetch_params.dart';
import 'package:flutter_marvel/src/widgets/alert_dialogs/error_dialog.dart';
import 'package:get/state_manager.dart';

class PaginatedGridView extends StatefulWidget {
  const PaginatedGridView({
    super.key,
    required this.controller,
    required this.gridDelegate,
    required this.itemBuilder,
    this.shrinkWrap = false,
    this.physics,
    this.params,
  });

  final BaseController controller;
  final SliverGridDelegate gridDelegate;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final FetchParams? params;

  @override
  State<PaginatedGridView> createState() => _PaginatedGridViewState();
}

class _PaginatedGridViewState extends State<PaginatedGridView> {
  fetchData() async {
    final result = await widget.controller.fetchItems(id: widget.params?.id);

    if (result.isLeft() && kDebugMode) {
      if (context.mounted) ErrorDialog.show(context, error: result.getLeft()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        gridDelegate: widget.gridDelegate,
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics,
        itemCount: widget.controller.itemsList.length + (widget.controller.hasMore ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index == widget.controller.itemsList.length - 1 && widget.controller.hasMore) {
            fetchData();
          }

          if (index == widget.controller.itemsList.length && widget.controller.hasMore) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return widget.itemBuilder(context, index);
        },
      );
    });
  }
}
