import 'package:flutter/material.dart';
import 'package:flutter_marvel/src/app_utils/app_colors.dart';
import 'package:flutter_marvel/src/app_utils/app_padding.dart';
import 'package:flutter_marvel/src/app_utils/app_padding_multiplier.dart';
import 'package:flutter_marvel/src/model/character_model.dart';
import 'package:flutter_marvel/src/view/character_details/character_details.dart';
import 'package:flutter_marvel/src/widgets/image_widgets/cache_image.dart';
import 'package:simple_shadow/simple_shadow.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.restorablePushNamed(
          context,
          CharacterDetailsView.routeName,
          arguments: character.id,
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.only(top: 130),
            padding: AppPadding.fromLTRB(top: PaddingMultiplier.x6),
            decoration: BoxDecoration(color: AppColors.primaryRed, borderRadius: BorderRadius.circular(10)),
            child: Text(
              character.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: character.id,
              child: SimpleShadow(
                sigma: 3,
                child: CacheImage(imageRadius: 100, image: character.thumbnail),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
