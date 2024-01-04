
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/utils/colors.dart';

import '../../../utils/widgets/common/_common.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {

  List<String> sampleList = <String>[
    'All',
    'Business',
    'Professional',
    'Members',
  ];
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 75, left: 30, right: 30),
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconWithCircleButton(
                iconData: Icons.people,
                width: 50.0,
                height: 50.0,
                bgColor: AppColors.primaryColor.withOpacity(0.2),
                iconColor: AppColors.primaryColor,
                margin: const EdgeInsets.only(right: 16),
                onTap: () {
                },
              ),
              Text(
                'Member Type',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              IconWithCircleButton(
                iconData: Icons.clear,
                width: 50.0,
                height: 50.0,
                bgColor: Colors.grey.withOpacity(0.2),
                iconColor: Colors.black,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sampleList.length,
              itemBuilder: (context, index) {
                String item = sampleList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedItem = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _selectedItem == index
                            ? AppColors.primaryColor : Colors.white,
                        // border: Border.all(color: borderColor, width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _selectedItem == index
                                    ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                            color: _selectedItem == index
                                ? Colors.white : Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}
