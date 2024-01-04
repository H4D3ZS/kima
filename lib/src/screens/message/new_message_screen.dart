import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/chat/chat_details_cubit.dart';
import 'package:kima/src/data/models/members.dart';
import 'package:kima/src/data/providers/member_provider.dart';
import 'package:kima/src/screens/message/chat_screen.dart';
import 'package:kima/src/utils/colors.dart';

import '../../data/models/message.dart';
import '../../utils/widgets/common/_common.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  static const route = '/new-message';

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  late ChatDetailsCubit _chatDetailsCubit;
  MemberProvider memberProvider = MemberProvider();
  final TextEditingController _searchController = TextEditingController();

  List<MessageModel> messageList = <MessageModel>[
    MessageModel(name: 'Rick Zafe', image: 'assets/temporary/img_temp_1.png', time: '12:00 PM', notif: 5),
    MessageModel(name: 'Monkey D. Luffy', image: 'assets/temporary/img_temp_2.jpeg', time: '10:40 AM', notif: 2),
    MessageModel(name: 'Roronnoa Zoro', image: 'assets/temporary/img_temp_3.png', time: '4:30 PM', notif: 1),
  ];

  void _initBloc() {
    _chatDetailsCubit = BlocProvider.of<ChatDetailsCubit>(context);
  }

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    CircularIconButton(
                      icon: Assets.icons.iconBack.svg(),
                      bgColor: Colors.transparent,
                      onTap: () => {
                        Navigator.pop(context)
                      },
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: Text(
                        'New Message',
                        style: GoogleFonts.comfortaa(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Stack(
                  children: [
                    TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Type a name',
                        hintStyle: TextStyle(color: AppColors.lightGrey ),
                        contentPadding: EdgeInsets.only(left: 50, top: 17, bottom: 17),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColors.lightGrey30,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            width:  2,
                            color: AppColors.lightGrey30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 17,
                      left: 17,
                      child: Assets.icons.iconSearchMessage.svg()
                    )
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Text('Suggested', style: GoogleFonts.poppins(
                  color: const Color(0xFF757575),
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                )),
              ),
              FutureBuilder<List<Members>>(
                future: memberProvider.getMembers(),
                builder: (BuildContext context, snapshot) {
                  print(snapshot.data);
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height - 350,
                      width: double.infinity,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, int index) => Column(
                          children: [
                            InkWell(
                              onTap: () {
                                _chatDetailsCubit.select(context, Members(
                                  id: snapshot.data![index].id,
                                  profileAvatar: snapshot.data![index].profileAvatar!,
                                  firstName: snapshot.data![index].firstName!,
                                  lastName: snapshot.data![index].lastName!
                                ));
                                Navigator.pushNamed(context, ChatScreen.route);
                              },
                              child: Row(
                                children: [
                                  snapshot.data![index].profileAvatar == null
                                  ? const CircleAvatar(backgroundColor: Color(0xFFE9E9E9))
                                  : CircleAvatar(
                                    backgroundColor: const Color(0xFFE9E9E9),
                                    foregroundImage: NetworkImage(snapshot.data![index].profileAvatar!),
                                  ),
                                  const HorizontalSpace(10),
                                  Text('${snapshot.data![index].firstName} ${snapshot.data![index].lastName}', style: GoogleFonts.poppins(
                                    color: const Color(0xFF1E1E1E),
                                    fontSize: 16
                                  ),)
                                ],
                              ),
                            ),
                            const VerticalSpace(10)
                          ],
                        )
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // return Text('${snapshot.error}');
                    return const Center(child: Text('No Content at the moment'),);
                  }
                  return const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

}
