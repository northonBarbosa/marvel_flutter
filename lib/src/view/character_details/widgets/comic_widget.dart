import 'package:flutter/material.dart';
import 'package:flutter_marvel/src/app_utils/app_colors.dart';
import 'package:flutter_marvel/src/app_utils/app_padding_multiplier.dart';
import 'package:flutter_marvel/src/app_utils/app_spacing.dart';
import 'package:flutter_marvel/src/model/comic_model.dart';
import 'package:flutter_marvel/src/widgets/image_widgets/cache_image.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ComicWidget extends StatelessWidget {
  const ComicWidget({
    super.key,
    required this.comic,
  });

  final ComicModel comic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SimpleShadow(
          child: CacheImage(
            height: 150,
            width: 100,
            imageRadius: 4,
            image: comic.thumbnail,
          ),
        ),
        AppSpacing.verticalSpace(multiplier: PaddingMultiplier.x2),
        Text(
          comic.title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.textDeepBlue),
          maxLines: 3,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
