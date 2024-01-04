import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/data/models/favorite.dart';
import 'package:kima/src/data/providers/member_provider.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

import '../../blocs/common/switch_view_cubit.dart';
import '../../data/global.dart';
import '../../data/models/favorite_model.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  static const route = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late SwitchViewCubit _switchViewCubit;

  MemberProvider memberProvider = MemberProvider();

  final TextEditingController _searchController = TextEditingController();

  List<FavoriteModel> favoriteList = <FavoriteModel>[
    FavoriteModel(name: 'Kima Idol', image: 'assets/temporary/img_temp_1.png', type: 'company'),
    FavoriteModel(name: 'Rafael Desuyo', image: 'assets/temporary/img_temp_2.jpeg', type: 'personal'),
    FavoriteModel(name: 'Rafael Desuyo', image: 'assets/temporary/img_temp_2.jpeg', type: 'personal'),
    FavoriteModel(name: 'Rafael Desuyo', image: 'assets/temporary/img_temp_2.jpeg', type: 'personal'),
    FavoriteModel(name: 'Rafael Desuyo', image: 'assets/temporary/img_temp_2.jpeg', type: 'personal'),
    FavoriteModel(name: 'Rafael Desuyo', image: 'assets/temporary/img_temp_2.jpeg', type: 'personal'),
    FavoriteModel(name: 'Rafael Desuyo', image: 'assets/temporary/img_temp_2.jpeg', type: 'personal')
  ];

  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    _initBloc();
    _searchController.addListener(() {
      setState(() {
        isSearch = _searchController.text != '';
      });
    });
  }

  void _initBloc() {
    _switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchTextFieldDefault(
          textController: _searchController,
          height: 50,
          margin: const EdgeInsets.only(right: 30),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 1,
        titleSpacing: 0,
        toolbarHeight: 95.0,
        leadingWidth: 110.0,
        leading: CircularIconButton(
          icon: Assets.icons.iconArrowLeft.svg(),
          bgColor: AppColors.lightGrey20,
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          onTap: () {
            _switchViewCubit.selectedRoute(FavoritesScreen.route);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: isSearch
              ? Container(
                  padding: const EdgeInsets.all(30),
                  child: ListView.builder(
                      itemCount: favoriteList.length,
                      itemBuilder: (BuildContext context, index) {
                        // return Text(favoriteList[index].name!);
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  radius: 27,
                                  backgroundImage: AssetImage(
                                    'assets/temporary/img_temp_1.png',
                                  ),
                                ),
                                const HorizontalSpace(20),
                                Text(
                                  favoriteList[index].name!,
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const VerticalSpace(20)
                          ],
                        );
                      }),
                )
              : FutureBuilder<List<Favorite>>(
                  future: memberProvider.getFavorites(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 48.0),
                          children: [
                            /// Default KIMA account
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: Assets.icons.kima.provider(),
                                ),
                                const VerticalSpace(5.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Kima',
                                    style: GoogleFonts.karla(fontSize: 15.0, fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              // color: Colors.grey.withOpacity(0.2),
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  // mainAxisExtent: MediaQuery.of(context).size.height * 0.05,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                    child: InkWell(
                                      onTap: () {
                                        /// Next ProfileScreen
                                        // _switchViewCubit.selectedRoute(1);
                                        Global.favoriteModel = favoriteList[index];
                                        // Navigator.pushNamed(context,
                                        //   ProfileScreen.route,
                                        //   // arguments: favoriteList[index],
                                        // );
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            radius: 27,
                                            backgroundImage: AssetImage(
                                              'assets/temporary/img_temp_1.png',
                                            ),
                                          ),
                                          const VerticalSpace(5),
                                          Text(
                                            '${snapshot.data![index].favoriteUser?.firstName ?? ''} ${snapshot.data![index].favoriteUser?.lastName ?? ''}',
                                            style: GoogleFonts.karla(
                                              fontSize: 15,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // return Text('${snapshot.error}');
                      print(snapshot.error);
                      return const Center(
                        child: Text('No Content at the moment'),
                      );
                    }

                    return Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        height: 40,
                        width: 40,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  })),
    );
  }
}
