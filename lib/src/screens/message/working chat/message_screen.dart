import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/data/providers/member_provider.dart';
import 'package:kima/src/data/providers/messaging_provider.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/get_user.dart';
import 'package:kima/src/utils/helpers/color_helpers.dart';
import 'package:kima/src/utils/widgets/common/circular_icon_button.dart';

class MessageScreen extends StatefulWidget {
  static const route = '/message';

  final String receiverName;
  final String receiverUserId;

  const MessageScreen({


    Key? key,
    required this.receiverName,
    required this.receiverUserId,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final MessageService _messageService = MessageService();

  MemberProvider memberProvider = MemberProvider();
  void _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          // Perform the state update here
        });
      }

      try {
        await _messageService.sendMessage(
          widget.receiverUserId,
          message,
          context,
        );
        // Check if the widget is still mounted before calling setState
        if (mounted) {
          setState(() {
            // Perform the state update here, if needed
          });
        }
        _messageController.clear();
      } catch (error) {
        // Handle the error here, e.g., show a snackbar with the error message.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error sending message: $error"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _messageService.getMessages(
            getUserId(context),
            widget.receiverUserId,
            context,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error! ${snapshot.error}"),
              );
            }
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  children: [
                    CircularIconButton(
                      icon: Assets.icons.iconBack.svg(),
                      bgColor: Colors.transparent,
                      onTap: () => {Navigator.pop(context)},
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFE9E9E9),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(widget.receiverName),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  CircularIconButton(
                    icon: Assets.icons.iconBack.svg(),
                    bgColor: Colors.transparent,
                    onTap: () => {Navigator.pop(context)},
                  ),
                  const SizedBox(
                    width: 15,
                  ),
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
            );
          },
        ),
        //siable arrow
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildMessages(context)),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessages(BuildContext context) {
    final currentUserId = getUserId(context);
    print("currentUserId: $currentUserId");
    print("widget.receiverUserId: ${widget.receiverUserId}");
    ScrollController scrollController = ScrollController();

    return StreamBuilder(
      stream: _messageService.getMessages(
        currentUserId,
        widget.receiverUserId,
        context,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error! ${snapshot.error}"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        print("snapshot.data!.docs.length: ${snapshot.data!.docs.length}");

        if (snapshot.data!.docs.isEmpty) {
          // Display a message when there are no messages
          return _noMessages();
        }

        Map<String, List<Map<String, dynamic>>> groupedMessages = {};

        for (int i = snapshot.data!.docs.length - 1; i >= 0; i--) {
          Map<String, dynamic> data =
              snapshot.data!.docs[i].data() as Map<String, dynamic>;

          //check if the message is hidden based on the senderId or receiverIdis equal to the currentUserId
          if (data['senderId'] == currentUserId) {
            //check if the message is hidden based on the senderId or receiverIdis equal to the currentUserId
            if (data['isHiddenUser1'] == true) {
              continue;
            }
          } else if (data['receiverId'] == currentUserId) {
            if (data['isHiddenUser2'] == true) {
              continue;
            }
          }

          final date = DateTime.parse(data['timestamp']).toLocal();
          final formattedDateTime =
              DateFormat('MMM dd, yyyy hh:mm a').format(date);

          // Check for the date and time
          if (!groupedMessages.containsKey(formattedDateTime)) {
            groupedMessages[formattedDateTime] = [];
          }

          groupedMessages[formattedDateTime]!.add(data);
        }

        List<Widget> messageWidgets = [];
        String? currentDate;
        String? currentTime;

        for (var entry in groupedMessages.entries) {
          String formattedDateTime = entry.key;
          List<Map<String, dynamic>> messages = entry.value;

          // Display the date at the top
          if (currentDate != formattedDateTime.substring(0, 12)) {
            currentDate = formattedDateTime.substring(0, 12);
            messageWidgets.insert(0, _buildDateHeader(currentDate));
            currentTime = null; // Reset currentTime when date changes
          }

          // Build message items
          for (var messageData in messages) {
            messageWidgets.insert(0, _buildMessageItem(messageData));
          }
          // Display the time for the last message within the same hour
          if (currentTime != formattedDateTime.substring(12)) {
            currentTime = formattedDateTime.substring(12);
            messageWidgets.insert(
              0,
              _buildTimeHeader(
                currentTime,
                messages[0]['senderId'],
                currentUserId,
              ),
            );
          }
        }

        // Scroll to the bottom when messages change
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });

        return Container(
          color: AppColors.lightGrey30,
          padding: const EdgeInsets.all(30),
          child: ListView(
            controller: scrollController,
            reverse: true,
            children: messageWidgets,
          ),
        );
      },
    );
  }

  Widget _buildTimeHeader(
      String formattedTime, String senderId, String currentUserId) {
    Alignment alignment = (senderId == currentUserId)
        ? Alignment.bottomRight
        : Alignment.bottomLeft;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 20),
        child: Text(
          formattedTime,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildDateHeader(String formattedDate) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        child: Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            formattedDate,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: HexColor('#9F9F9F'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> data) {
    final currentUserId = getUserId(context);

    final date = DateTime.parse(data['timestamp']).toLocal();
    final formattedTime = DateFormat.jm().format(date);

    var alignment = (data['senderId'] == currentUserId)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMessageContent(data, formattedTime, alignment),
      ],
    );
  }

  Widget _buildMessageContent(
      Map<String, dynamic> data, String formattedTime, Alignment alignment) {
    final currentUserId = getUserId(context);
    return Container(
      alignment: alignment,
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: (data['senderId'] == currentUserId)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: data['senderId'] == currentUserId
                  ? AppColors.green
                  : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
              data['message'],
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: data['senderId'] == currentUserId
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 5),
          //   child: Text(
          //     formattedTime,
          //     style: GoogleFonts.poppins(
          //       fontSize: 13,
          //       color: Colors.grey,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  //build message composer
  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 90,
            child: TextField(
              controller: _messageController,
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
                hintStyle: TextStyle(color: AppColors.lightGrey),
                filled: true,
                fillColor: AppColors.lightGrey30,
                contentPadding: EdgeInsets.only(left: 20, top: 17, bottom: 17),
                // border: const OutlineInputBorder(
                //   borderSide: BorderSide(color: Colors.grey),
                //   borderRadius: BorderRadius.all(Radius.circular(20)),
                // ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(width: 20,),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          //   decoration: const BoxDecoration(
          //     color: AppColors.lightGrey30,
          //     borderRadius: BorderRadius.only(
          //         topRight: Radius.circular(100),
          //         bottomRight: Radius.circular(100)),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       InkWell(
          //         onTap: () => {},
          //         child: Assets.icons.iconSelectPhoto.svg(),
          //       ),
          //       const SizedBox(
          //         width: 20,
          //       ),
          //       InkWell(
          //         onTap: () => {},
          //         child: Assets.icons.iconSelectEmoji.svg(),
          //       )
          //     ],
          //   ),
          // ),
          IconButton(
              color: const Color(0xFF757575),
              icon: const Icon(Icons.send),
              onPressed: _sendMessage)
        ],
      ),
    );
  }

  Widget _noMessages() {
    return Container(
      color: AppColors.lightGrey30,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          //container with border and color white containing To: widget.receiverName
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFFE9E9E9),
                width: 1,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Text(
              "To: ${widget.receiverName}",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          const CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFFE9E9E9),
            // backgroundImage: NetworkImage(
            //   items[index]['receipientAvatar'],
            // ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.receiverName,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "He's in your favorites",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF757575),
            ),
          ),
          //button for view profile
          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 0,
              ),
              child: const Text(
                'View Profile',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
