// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:kima/gen/assets.gen.dart';
// import 'package:kima/src/blocs/main/chat/chat_details_cubit.dart';
// import 'package:kima/src/data/providers/member_provider.dart';
// import 'package:kima/src/data/providers/messaging_provider.dart';
// import 'package:kima/src/screens/message/chat_screen.dart';
// import 'package:kima/src/screens/message/working%20chat/new_message_screen.dart';
// // import 'package:kima/src/screens/message/new_message_screen.dart';
// import 'package:kima/src/utils/colors.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:kima/src/utils/configs.dart';
// import 'package:kima/src/utils/get_user.dart';
// import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';
// import 'package:kima/src/data/models/members.dart';
// import '../../data/models/message.dart';
// import '../../utils/widgets/common/_common.dart';

// class MessageScreen extends StatefulWidget {
//   const MessageScreen({super.key});

//   static const route = '/message';

//   @override
//   State<MessageScreen> createState() => _MessageScreenState();
// }

// class _MessageScreenState extends State<MessageScreen> {
//   MemberProvider memberProvider = MemberProvider();
//   final MessageService _messageService = MessageService();

//   late ChatDetailsCubit _chatDetailsCubit;
//   List<dynamic> chats = [];
//   void initMessages() async {
//     final token = await readStringSharedPref(spProfileJwt);
//     final tokenDecoded = JwtDecoder.decode(token!);
//     final userID = tokenDecoded['id'];
//     DatabaseReference ref = FirebaseDatabase.instance.ref('chats');
//     ref.onValue.listen((DatabaseEvent event) {
//       final data = event.snapshot.value;

//       final jsonData = json.encode(data);
//       Map<String, dynamic> decoded = json.decode(jsonData);
//       for (var jsonItem in decoded.keys) {
//         if (jsonItem.contains(userID)) {
//           var itemData = decoded[jsonItem];
//           var messages = itemData['messages'];
//           for (var secondChild in messages.keys) {
//             print(messages[secondChild]);
//             setState(() {
//               chats.add(messages[secondChild]);
//             });
//           }
//         }
//       }
//     });
//   }

//   // Function to add members to Firestore
//   void addMembers() async {
//     // Get the members from memberProvider
//     memberProvider.getMembers().then((members) {
//       // Loop through the members
//       members.forEach((member) async {
//         // Check if the member with the same ID already exists in Firestore
//         bool memberExists = await checkMemberExists(member.id!);

//         if (!memberExists) {
//           //Add the member to Firestore
//           await FirebaseFirestore.instance
//               .collection('users')
//               .doc(member.id)
//               .set({
//             'id': member.id,
//             'firstName': member.firstName,
//             'lastName': member.lastName,
//             'email': member.email,
//           });

//           // print('Member added with ID: ${member.id}');
//           // print('Member added with first name: ${member.firstName}');
//           // print('Member added with last name: ${member.lastName}');
//           // print('Member added with email: ${member.email}');
//         } else {
//           //print('Member with ID ${member.id} already exists in Firestore.');
//         }
//       });
//     });
//   }

//   void printChatRooms() {
//     FirebaseFirestore.instance
//         .collection('chatRooms')
//         .get()
//         .then((querySnapshot) {
//       for (var chatRoom in querySnapshot.docs) {
//         print('Document ID: ${chatRoom.id}');

//         print('------------------------');
//       }
//     }).catchError((e) {
//       print('Error fetching chat rooms: $e');
//     });
//   }

//   // Function to check if a member with the given ID already exists in Firestore
//   Future<bool> checkMemberExists(String memberId) async {
//     DocumentSnapshot memberSnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(memberId)
//         .get();
//     return memberSnapshot.exists;
//   }

//   void _initBloc() {
//     _chatDetailsCubit = BlocProvider.of<ChatDetailsCubit>(context);
//     addMembers();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initBloc();
//     initMessages();
//     printChatRooms();
//   }

//   final TextEditingController _searchController = TextEditingController();

//   List<MessageModel> messageList = <MessageModel>[
//     MessageModel(
//         name: 'Rick Zafe',
//         image: 'assets/temporary/img_temp_1.png',
//         time: '12:00 PM',
//         notif: 5),
//     MessageModel(
//         name: 'Monkey D. Luffy',
//         image: 'assets/temporary/img_temp_2.jpeg',
//         time: '10:40 AM',
//         notif: 2),
//     MessageModel(
//         name: 'Roronnoa Zoro',
//         image: 'assets/temporary/img_temp_3.png',
//         time: '4:30 PM',
//         notif: 1),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Messages',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         elevation: 1,
//         toolbarHeight: 95.0,
//         leadingWidth: 110.0,
//         leading: CircularIconButton(
//           icon: Assets.icons.iconArrowLeft.svg(),
//           bgColor: AppColors.lightGrey20,
//           margin: const EdgeInsets.symmetric(horizontal: 30.0),
//           onTap: () => {},
//           // onTap: () {
//           //   Navigator.pop(context);
//           // },
//         ),
//         actions: [
//           GestureDetector(
//               onTap: () => {
//                     // _key.currentState!.openEndDrawer()
//                     // Navigator.pushNamed(context, NewMessageScreen.route)
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) {
//                       return const NewMessageScreen();
//                     }))
//                   },
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: Assets.svg.svgNewMessage.svg(),
//               ))
//         ],
//       ),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SizedBox(
//           width: double.infinity,
//           height: double.infinity,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: SizedBox(
//                   height: 40,
//                   child: TextField(
//                     controller: _searchController,
//                     // autofocus: true,
//                     // inputFormatters: <TextInputFormatter>[
//                     //   // LengthLimitingTextInputFormatter(Global.searchCharacterLimit),
//                     // ],
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                     ),
//                     // onChanged: onChanged,
//                     decoration: InputDecoration(
//                       hintText: 'Search message or people',
//                       hintStyle: const TextStyle(color: AppColors.lightGrey),
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding:
//                           const EdgeInsets.symmetric(horizontal: 10),
//                       prefixIcon: IconButton(
//                         splashColor: Colors.transparent,
//                         highlightColor: Colors.transparent,
//                         icon: Assets.icons.iconSearchMessages.svg(),
//                         color: Colors.white,
//                         onPressed: () {
//                           // onTapClear();
//                         },
//                       ),
//                       border: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey),
//                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                       ),
//                       enabledBorder: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                         borderSide: BorderSide(
//                           width: 1.0,
//                           color: AppColors.lightGrey40,
//                         ),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                         borderSide: BorderSide(
//                           width: 1.0,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: _buildList(chats),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildList(List<dynamic> items) {
//     return ListView.builder(
//       physics: const AlwaysScrollableScrollPhysics(),
//       itemCount: items.length,
//       itemBuilder: (BuildContext context, int index) {
//         print(items[index]['text']);
//         return Container(
//           margin: const EdgeInsets.fromLTRB(16, 2, 16, 16),
//           width: double.infinity,
//           // height: 50,
//           decoration: const BoxDecoration(
//             color: AppColors.lightGrey30,
//             // border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
//             borderRadius: BorderRadius.all(Radius.circular(8)),
//           ),
//           child: InkWell(
//             onTap: () {
//               _chatDetailsCubit.select(
//                   context,
//                   Members(
//                       id: items[index]['senderUid'],
//                       profileAvatar: items[index]['receipientAvatar'],
//                       firstName: items[index]['receipientName'] ?? 'user'));
//               Navigator.pushNamed(context, ChatScreen.route);
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                       radius: 27,
//                       backgroundColor: const Color(0xFFE9E9E9),
//                       backgroundImage:
//                           NetworkImage(items[index]['receipientAvatar'])),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 items[index]['receipientName'] ?? '',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               items[index]['timestamp'].toString(),
//                               style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 color: AppColors.lightGrey,
//                               ),
//                               maxLines: 1,
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 items[index]['text'],
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 12, color: AppColors.lightGrey),
//                                 maxLines: 1,
//                               ),
//                             ),
//                             // Container(
//                             //   width: 18,
//                             //   height: 18,
//                             //   decoration: BoxDecoration(
//                             //     color: AppColors.green,
//                             //     borderRadius: BorderRadius.circular(18.0),
//                             //   ),
//                             //   child: Text(
//                             //     messageList[index].notif!.toString(),
//                             //     textAlign: TextAlign.center,
//                             //     style: const TextStyle(
//                             //       color: Colors.white,
//                             //       fontSize: 12,
//                             //     ),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
