import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel/src/controllers/characters_controller.dart';
import 'package:flutter_marvel/src/app_utils/app_extensions.dart';
import 'package:flutter_marvel/src/view/characters_list/widgets/character_widget.dart';
import 'package:flutter_marvel/src/widgets/base/base_screen_widget.dart';
import 'package:flutter_marvel/src/widgets/alert_dialogs/error_dialog.dart';
import 'package:flutter_marvel/src/widgets/scroll_widgets/sliver_paginated_gridview.dart';
import 'package:get/state_manager.dart';

class CharactersListView extends StatefulWidget {
  const CharactersListView({
    super.key,
  });

  static const routeName = '/';

  @override
  State<CharactersListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<CharactersListView> {
  final CharactersController _charactersController = CharactersController();

  final RxBool isLoading = true.obs;

  @override
  void initState() {
    fetchCharacters();
    super.initState();
  }

  fetchCharacters() async {
    final result = await _charactersController.fetchItems();

    if (mounted) isLoading.value = false;

    if (result.isLeft() && kDebugMode) {
      if (mounted) ErrorDialog.show(context, error: result.getLeft()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenWidget(
      screenTitle: 'Characters',
      child: Obx(() {
        return isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(slivers: [
                SliverPaginatedGridView(
                  controller: _charactersController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 220,
                  ),
                  itemBuilder: (context, index) {
                    return CharacterWidget(
                      character: _charactersController.itemsList[index],
                    );
                  },
                ),
              ]);
      }),
    );
  }
}
