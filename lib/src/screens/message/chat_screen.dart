
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kima/src/blocs/main/chat/chat_details_cubit.dart';
import 'package:kima/src/data/models/chat_model.dart';
import 'package:kima/src/data/providers/chat_provider.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/helpers/color_helpers.dart';
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';
import 'package:kima/src/utils/widgets/common/circular_icon_button.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const route = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatDetailsCubit _chatDetailsCubit;
  ChatProvider chatProvider = ChatProvider();
  final TextEditingController chatController = TextEditingController();
  String chatID = '';

  List<ChatModel> chatList = <ChatModel>[
    ChatModel(title: 'Hello', date: 'May. 18, 2023', time: '11:00 AM', messageType: 'receiver'),
    ChatModel(title: 'Hi', date: 'Aug. 15, 2023', time: '10:13 AM', messageType: 'sender'),
    ChatModel(title: 'world', date: 'Aug. 15, 2023', time: '10:18 AM', messageType: 'sender'),
    ChatModel(title: 'Thank you', date: 'Aug. 25, 2023', time: '1:30 PM', messageType: 'receiver'),
    ChatModel(title: 'Hahaha', date: 'Sep. 01, 2023', time: '5:45 PM', messageType: 'sender'),
  ];

  void _initBloc() {
    _chatDetailsCubit = BlocProvider.of<ChatDetailsCubit>(context);
  }

  void initMessages() async {
    final token = await readStringSharedPref(spProfileJwt);
    final tokenDecoded = JwtDecoder.decode(token!);
    final userID = tokenDecoded['id'];

    if (_chatDetailsCubit.state != null) {
      final chatID = [userID, _chatDetailsCubit.state!.id];
      print('chatID $chatID');
      chatID.sort();
      final chatData = chatID.join('_');
      print(chatData);

      DatabaseReference ref = FirebaseDatabase.instance.ref('chats/$chatData/messages');
      ref.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        print('CHAT DATA ==== $data');
      });
    } else {
      print('ChatDetailsCubit state is null.');
    }
  }

  @override
  void initState() {
    super.initState();
    _initBloc();
    initMessages();
  }

  void sendMessage() async {
    print('uid : ${_chatDetailsCubit.state!.id!.toString()}');
    print('message : ${chatController.text}');
    await chatProvider.sendMessage({
      'recipient': _chatDetailsCubit.state!.id!.toString(),
      'message': chatController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = _chatDetailsCubit.state;
    final avatar = state?.profileAvatar;
    final fullName = '${state?.firstName ?? ''} ${state?.lastName ?? ''}';
    // final memberID = state?.id as String;
    final memberID = state?.id ?? '';

    setState(() {
      chatID = memberID;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(avatar.toString()),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Text(
                        fullName,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.lightGrey30,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildChatList(),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 210,
                      child: TextField(
                        controller: chatController,
                        // autofocus: true,
                        // inputFormatters: <TextInputFormatter>[
                        //   // LengthLimitingTextInputFormatter(Global.searchCharacterLimit),
                        // ],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        // onChanged: onChanged,
                        decoration: const InputDecoration(
                          hintText: 'Type here',
                          hintStyle: TextStyle(color: AppColors.lightGrey ),
                          filled: true,
                          fillColor: AppColors.lightGrey30,
                          contentPadding: EdgeInsets.only(left: 20, top: 17, bottom: 17),
                          // border: const OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.grey),
                          //   borderRadius: BorderRadius.all(Radius.circular(20)),
                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(100), bottomLeft: Radius.circular(100)),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(100), bottomLeft: Radius.circular(100)),
                            borderSide: BorderSide(
                              width:  1.0,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 20,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                      decoration: const BoxDecoration(
                        color: AppColors.lightGrey30,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(100), bottomRight: Radius.circular(100)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => {},
                            child: Assets.icons.iconSelectPhoto.svg(),
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: () => {},
                            child: Assets.icons.iconSelectEmoji.svg(),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      color: const Color(0xFF757575),
                      icon: const Icon(Icons.send),
                      onPressed: sendMessage
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: chatList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: double.infinity,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  // width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text(
                      chatList[index].date!,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: HexColor('#9F9F9F'),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: chatList[index].messageType == 'receiver'
                    ? Alignment.topLeft
                    : Alignment.topRight,
                child: Column(
                  crossAxisAlignment: chatList[index].messageType == 'receiver'
                      ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: chatList[index].messageType == 'receiver'
                            ? Colors.white : AppColors.green,
                        // border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text(
                        chatList[index].title!,
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          color: chatList[index].messageType == 'receiver'
                              ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        chatList[index].time!,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
