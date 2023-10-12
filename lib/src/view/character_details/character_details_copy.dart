import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel/src/app_utils/app_colors.dart';
import 'package:flutter_marvel/src/app_utils/app_padding_multiplier.dart';
import 'package:flutter_marvel/src/app_utils/app_spacing.dart';
import 'package:flutter_marvel/src/controllers/characters_controller.dart';
import 'package:flutter_marvel/src/app_utils/app_extensions.dart';
import 'package:flutter_marvel/src/controllers/comics_controller.dart';
import 'package:flutter_marvel/src/model/character_model.dart';
import 'package:flutter_marvel/src/model/fetch_params.dart';
import 'package:flutter_marvel/src/view/character_details/widgets/comic_widget.dart';
import 'package:flutter_marvel/src/widgets/base/base_screen_widget.dart';
import 'package:flutter_marvel/src/widgets/alert_dialogs/error_dialog.dart';
import 'package:flutter_marvel/src/widgets/image_widgets/cache_image.dart';
import 'package:flutter_marvel/src/widgets/scroll_widgets/sliver_paginated_gridview.dart';
import 'package:get/state_manager.dart';
import 'package:simple_shadow/simple_shadow.dart';

class CharacterDetailsView extends StatefulWidget {
  const CharacterDetailsView({super.key, required this.characterId});

  static const routeName = '/character_details';

  final int characterId;

  @override
  State<CharacterDetailsView> createState() => _CharacterDetailsViewState();
}

class _CharacterDetailsViewState extends State<CharacterDetailsView> {
  late final CharacterModel _character;

  final ComicsController _comicsController = ComicsController();
  final RxBool _isLoadingComics = true.obs;

  @override
  void initState() {
    _character = CharactersController().itemsList.firstWhere(
          (character) => character.id == widget.characterId,
        );

    if (_comicsController.currentCharacterId != widget.characterId) {
      _comicsController.clearCharacterComics();
      _fetchComics();
    } else {
      _isLoadingComics.value = false;
    }

    super.initState();
  }

  void _fetchComics() async {
    final result = await _comicsController.fetchItems(id: widget.characterId);

    if (mounted) _isLoadingComics.value = false;

    if (result.isLeft() && kDebugMode) {
      if (mounted) ErrorDialog.show(context, error: result.getLeft()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenWidget(
      screenTitle: _character.name,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Center(
                  child: Hero(
                    tag: _character.id,
                    child: SimpleShadow(
                      child: CacheImage(height: 200, width: 200, image: _character.thumbnail),
                    ),
                  ),
                ),
                AppSpacing.verticalSpace(multiplier: PaddingMultiplier.x6),
                Text(
                  _character.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.textDeepBlue),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.verticalSpace(multiplier: PaddingMultiplier.x6),
                Text(
                  _character.description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.textDeepBlue,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                  textAlign: TextAlign.justify,
                ),
                AppSpacing.verticalSpace(multiplier: PaddingMultiplier.x8),
              ],
            ),
          ),
          Obx(() {
            return _isLoadingComics.value
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SliverPaginatedGridView(
                    controller: _comicsController,
                    params: FetchParams(id: widget.characterId),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 210,
                    ),
                    itemBuilder: (context, index) {
                      return ComicWidget(comic: _comicsController.itemsList[index]);
                    },
                  );
          }),
        ],
      ),
    );
  }
}
