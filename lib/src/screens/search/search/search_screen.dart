import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/search_community/community_bloc.dart';
import 'package:kima/src/screens/qrcode/qr_code_scanner_screen.dart';
import 'package:kima/src/screens/search/search/drawer_view.dart';
import 'package:kima/src/screens/search/search/widgets/search_card_grid_layout.dart';
import 'package:kima/src/screens/search/search/widgets/search_card_list_layout.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_error_widget.dart';
import 'package:kima/src/utils/widgets/customs/custom_loading_widget.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/helpers/color_helpers.dart';
import 'package:kima/src/utils/widgets/common/header_wrapper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const route = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final TextEditingController _searchController = TextEditingController();

  late Layout _layout = Layout.grid;
  late CommunityBloc _communityBloc;

  // TODO: Search implementation
  bool hasSearch = false;

  @override
  void initState() {
    _communityBloc = BlocProvider.of<CommunityBloc>(context);
    _communityBloc.add(const GetAllCommunityEvent());

    _searchController.addListener(() {
      setState(() {
        hasSearch = _searchController.text != '';
      });
    });
    super.initState();
  }

  bool get _isDefaultLayout => _layout == Layout.grid;

  @override
  Widget build(BuildContext context) {
    return HeaderWrapper(
      keyName: _key,
      titleHeader: 'Community',
      onBack: () => {},
      elevation: 1,
      actions: [
        GestureDetector(
          onTap: () => _key.currentState!.openEndDrawer(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Assets.svg.svgMenu.svg(),
          ),
        )
      ],
      endDrawer: const DrawerView(),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.0,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        controller: _searchController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search something here',
                          hintStyle: const TextStyle(color: AppColors.lightGrey10),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(right: 9.0, bottom: Platform.isIOS ? 14.0 : 13.0),
                          prefixIcon: IconButton(
                            padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 15.0),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Assets.icons.iconSearch.svg(),
                            color: Colors.white,
                            onPressed: () {
                              // onTapClear();
                            },
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFD9D9D9)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color(0xFFD9D9D9),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  RoundedSquareIconButton(
                    icon: Assets.icons.iconQrWhite.svg(),
                    padding: const EdgeInsets.only(left: 15.0),
                    onTap: () => Navigator.pushNamed(context, QRCodeScannerScreen.route),
                  ),
                  RoundedSquareIconButton(
                    icon: _isDefaultLayout ? Assets.icons.iconGrid.svg() : Assets.icons.list.svg(),
                    buttonColor: AppColors.green.withOpacity(0.12),
                    padding: const EdgeInsets.only(left: 15.0),
                    onTap: () => setState(() => _layout = _isDefaultLayout ? Layout.list : Layout.grid),
                  ),
                ],
              ),
            ),
            const VerticalSpace(20.0),
          ],
        ),
      ),
      body: BlocBuilder<CommunityBloc, CommunityState>(
        builder: (BuildContext context, state) {
          if (!state.isInitialLoading && !state.users.isNotNullNorEmpty) {
            return const CustomLoadingWidget();
          }

          if (state.users.isNotNullNorEmpty) {
            final allUsers = state.users!;
            final filteredUsers = allUsers
                .where((user) =>
            user.firstName?.toLowerCase().contains(_searchController.text.toLowerCase()) == true ||
                user.lastName?.toLowerCase().contains(_searchController.text.toLowerCase()) == true ||
                '${user.firstName} ${user.lastName}'
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) == true)
                .toList();

            final currentPage = state.currentPage!;
            final totalPages = state.totalPages!;

            return _isDefaultLayout
                ? SearchCardGridLayout(
              filteredUsers..shuffle(),
              isLoadingMore: state.isLoadingMore,
              currentPage: currentPage,
              totalPages: totalPages,
            )
                : SearchCardListLayout(
              filteredUsers,
              isLoadingMore: state.isLoadingMore,
              currentPage: currentPage,
              totalPages: totalPages,
            );
          }

          if (state.error != null) {
            return const CustomErrorWidget();
          }

          return const CustomLoadingWidget();
        },
      ),
    );
  }

  Widget displayName(List<String> nameList) {
    String name = nameList.join(' ');
    return Text(name,
        style: GoogleFonts.comfortaa(fontSize: 18.0, fontWeight: FontWeight.w600, color: HexColor('#FFFFFF')));
  }

  Widget showCase({required String type}) {
    // TODO: for clarifications
    // String showText = '';

    // switch (type) {
    //   case 'business':
    //     showText = '';
    //     break;
    //   case 'professional':
    //     showText = 'job title here';
    //     break;
    //   default:
    //     showText = 'user';
    //     break;
    // }

    return Text(type,
        style: GoogleFonts.poppins(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: HexColor('#FFFFFF'),
        ));
  }

  Widget _iconButtons({
    required Widget iconData,
    Color bgColor = Colors.black,
    Color iconColor = Colors.white,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Center(child: iconData),
      ),
    );
  }
}

/// Common TextField Widget ----------------------------------------------------
class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.textController,
    this.inputFormatters,
    this.icon,
    this.hintText,
    this.labelText,
    this.errorText,
    this.counterText = '',
    this.isObscure = false,
    this.hintColor = Colors.grey,
    this.labelColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.textColor = Colors.black,
    this.obscureColor = Colors.grey,
    this.cursorColor = Colors.white,
    this.fontSize,
    this.hintFontSize,
    this.labelFontSize,
    this.focusNode,
    this.autoFocus = false,
    this.readOnly = false,
    this.maxLength = 255,
    this.maxLines,
    this.borderRadius = 25,
    this.fillColor = Colors.white,
    this.focusedBorderColor = Colors.white,
    this.enabledBorderColor = Colors.white,
    this.disabledBorderColor = Colors.white,
    this.errorBorderColor = Colors.red,
    this.focusedErrorBorderColor = Colors.red,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
    this.textInputType,
    this.inputAction,
    this.textCapitalization = TextCapitalization.none,
    this.startIcon,
    this.endIcon,
    this.margin = const EdgeInsets.all(0),
    this.contentPadding,
    this.focusedBorderWidth = 1.0,
    this.enabledBorderWidth = 1.0,
    this.disabledBorderWidth = 1.0,
    this.errorBorderWidth = 1.0,
    this.focusedErrorBorderWidth = 1.0,
  }) : super(key: key);

  final TextEditingController textController;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? icon;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String counterText;
  final bool isObscure;
  final Color hintColor;
  final Color labelColor;
  final Color iconColor;
  final Color textColor;
  final Color obscureColor;
  final Color cursorColor;
  final double? fontSize;
  final double? hintFontSize;
  final double? labelFontSize;
  final FocusNode? focusNode;
  final bool autoFocus;
  final bool readOnly;
  final int maxLength;
  final int? maxLines;
  final double borderRadius;
  final Color fillColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color disabledBorderColor;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final TextInputAction? inputAction;
  final TextCapitalization textCapitalization;
  final Widget? startIcon;
  final Widget? endIcon;
  final EdgeInsets margin;
  final EdgeInsets? contentPadding;
  final double focusedBorderWidth;
  final double enabledBorderWidth;
  final double disabledBorderWidth;
  final double errorBorderWidth;
  final double focusedErrorBorderWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextFormField(
        controller: textController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        textCapitalization: textCapitalization,
        obscureText: isObscure,
        maxLength: maxLength,
        maxLines: maxLines,
        readOnly: readOnly,
        keyboardType: textInputType == null ? TextInputType.text : textInputType!,
        style: TextStyle(color: textColor, fontSize: fontSize),
        cursorColor: cursorColor,
        inputFormatters: inputFormatters, //[FilteringTextInputFormatter(RegExp("[ A-Za-z0-9_@./#&+-]"), allow: true)],
        validator: validator,
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Please enter some text';
        //   }
        //   return null;
        // },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: hintFontSize, color: hintColor),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: labelFontSize, color: labelColor),
          errorText: errorText,
          counterText: counterText,
          isDense: true,

          /// this will remove the default content padding
          /// now you can customize it here or add padding widget
          contentPadding: contentPadding, //const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          filled: true,
          fillColor: fillColor,
          prefixIcon: startIcon == null ? null : startIcon!,
          suffixIcon: endIcon == null ? null : endIcon!,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor, width: focusedBorderWidth),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: enabledBorderWidth),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: disabledBorderColor, width: disabledBorderWidth),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorBorderColor, width: errorBorderWidth),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedErrorBorderColor, width: focusedErrorBorderWidth),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
      ),
    );
  }
}
