
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/utils/colors.dart';

import '../../blocs/common/switch_view_cubit.dart';
import '../../utils/widgets/common/_common.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  static const route = '/profile/about';

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late SwitchViewCubit _switchViewCubit;

  @override
  void initState() {
    super.initState();
    _initBloc();
  }

  void _initBloc() {
    _switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Rafael',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: CircularIconButton(
          icon: Assets.icons.iconArrowLeft.svg(),
          bgColor: Colors.grey.withOpacity(0.2),
          margin: const EdgeInsets.all(8),
          onTap: () {
            // Navigator.pop(context);
            /// Next ProfileSettingScreen
            // _switchViewCubit.selectedRoute(2);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleWidget(
                  title: 'Basic Information',
                ),
                _buildInfoWithIconWidget(
                  iconData: Icons.person,
                  title: 'Gender',
                  data: 'Male',
                  margin: const EdgeInsets.only(top: 10),
                ),
                _buildInfoWithIconWidget(
                  iconData: Icons.card_giftcard,
                  title: 'Birthday',
                  data: 'September 12, 1995',
                  margin: const EdgeInsets.only(top: 10),
                ),
                _buildTitleWidget(
                  title: 'Contact Information',
                  margin: const EdgeInsets.only(top: 10),
                ),
                _buildInfoWithIconWidget(
                  iconData: Icons.phone,
                  title: 'Mobile Number',
                  data: '09123456789',
                  margin: const EdgeInsets.only(top: 10),
                ),
                _buildInfoWithIconWidget(
                  iconData: Icons.mail,
                  title: 'Email',
                  data: 'rafaeldesuyo@gmail.com',
                  margin: const EdgeInsets.only(top: 10),
                ),
                _buildTitleWidget(
                  title: 'About',
                  margin: const EdgeInsets.only(top: 10),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleWidget({required String title, EdgeInsets margin = EdgeInsets.zero}) {
    return Padding(
      padding: margin,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoWithIconWidget({
    required IconData iconData, required String title, required String data,
    EdgeInsets margin = EdgeInsets.zero,
  }) {
    return Padding(
      padding: margin,
      child: Row(
        children: [
          Icon(
            iconData,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Text(
                  data,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
