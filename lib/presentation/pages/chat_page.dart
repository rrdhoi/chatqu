import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageTextController = TextEditingController();
  final _scrollController = ScrollController();
  late UserEntity _userReceiver;
  bool _isMessageEmpty = false;

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _userReceiver = UserEntity.fromMap(argument);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, _userReceiver),
            Expanded(
              child: BlocListener<SendMessageCubit, SendMessageState>(
                listener: (_, sendMessageState) {
                  if (sendMessageState is SendMessageLoaded) {
                    if (_isMessageEmpty) {
                      context
                          .read<GetChatMessagesCubit>()
                          .checkChatExist(_userReceiver.userId!);
                      _isMessageEmpty = false;
                    }
                  }
                },
                child: BlocBuilder<GetChatMessagesCubit, GetChatMessagesState>(
                  builder: (_, state) {
                    if (state is GetChatMessagesLoaded) {
                      return StreamBuilder<List<MessageEntity>>(
                        stream: state.chats,
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return BlocBuilder<GetUserDataCubit,
                                GetUserDataState>(
                              builder: (_, stateUser) {
                                if (stateUser is GetUserDataLoaded) {
                                  scrollToBottom();
                                  return _buildListMessage(
                                    snapshot.data!,
                                    stateUser.user,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      );
                    } else if (state is GetChatMessagesError) {
                      _isMessageEmpty = true;
                      debugPrint('state.message: ${state.message}');
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            ..._buildInputChat(context, _userReceiver),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserEntity user) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomNavigatorButton(
              icon: const Icon(Icons.arrow_back_ios, size: 18),
              onTap: () => Navigator.pop(context),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              user.name!,
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListMessage(
    List<MessageEntity> chats,
    UserEntity myUser,
  ) =>
      ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 24, right: 24, top: 18),
        itemCount: chats.length,
        itemBuilder: (_, index) => ChatBubble(
          imgProfile: myUser.userId == chats[index].sendBy
              ? myUser.imageProfile
              : _userReceiver.imageProfile,
          message: chats[index].message,
          sendAt: chats[index].sendAt,
          isMe: myUser.userId == chats[index].sendBy ? true : false,
        ),
      );

  List<Widget> _buildInputChat(BuildContext context, UserEntity userReceiver) =>
      [
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 56,
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(
                  controller: _messageTextController,
                  maxLines: 1,
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                  cursorColor: AppColors.greenColor,
                  decoration: InputDecoration(
                    hintText: 'Ketik Pesan',
                    hintStyle: GoogleFonts.quicksand(
                      color: AppColors.greyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _sendMessage(context, userReceiver),
              child: Container(
                height: 56,
                width: 56,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(AssetsPath.icSend, width: 26),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ];

  void _sendMessage(BuildContext context, UserEntity userReceiver) {
    final message = MessageEntity(
      message: _messageTextController.text,
      sendBy: '',
      sendAt: DateTime.now().toString(),
    );
    context.read<SendMessageCubit>().sendMessage(message, userReceiver.userId!);
    _messageTextController.clear();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _messageTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
