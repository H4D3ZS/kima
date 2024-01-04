import 'package:flutter/material.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/data/providers/member_provider.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class ClassifiedsUserFavorite extends StatefulWidget {
  const ClassifiedsUserFavorite({
    Key? key,
    required this.user,
    required this.joinedDate,
    this.onFavorite,
    this.id,
    this.avatar,
  }) : super(key: key);

  final int? id;
  final String user;
  final String joinedDate;
  final String? avatar;
  final void Function(bool)? onFavorite;

  @override
  State<ClassifiedsUserFavorite> createState() => _ClassifiedsUserFavoriteState();
}

class _ClassifiedsUserFavoriteState extends State<ClassifiedsUserFavorite> {
  MemberProvider memberProvider = MemberProvider();
  bool isFavorite = false;

  void handleFavorite() {
    widget.onFavorite!(isFavorite);
    setState(() => isFavorite = !isFavorite);
  }

  void getFavorites() async {
    final favorites = await memberProvider.getFavorites();
    final allFavorites = favorites.map((x) => x.id.toString());
    print(allFavorites);
    // setState(() {
    //   isFavorite = allFavorites.contains(widget.id);
    // });
  }

  @override
  void initState() {
    getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            // CircularAvatarName displays image of the current logged in user
            child: CircularAvatarName(
              title: widget.user,
              subtitle: 'Joined in ${widget.joinedDate}',
              image: widget.avatar,
            ),
          ),
          CircularIconButton(
              icon: Assets.icons.heart.svg(colorFilter: (isFavorite ? Colors.white : Colors.black).toColorFilter),
              height: 50.0,
              width: 50.0,
              bgColor: isFavorite ? AppColors.pink : Colors.white,
              borderColor: isFavorite ? null : AppColors.white5,
              onTap: handleFavorite),
        ],
      );
}
