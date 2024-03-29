import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/domain/entities/chat_arguments.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalChatPage extends StatefulWidget {
  const PersonalChatPage({Key? key}) : super(key: key);

  @override
  State<PersonalChatPage> createState() => _PersonalChatPageState();
}

class _PersonalChatPageState extends State<PersonalChatPage> {
  final _messageTextController = TextEditingController();
  final _scrollController = ScrollController();
  late PersonalChatArguments arguments;
  bool _isMessageEmpty = false;

  @override
  void didChangeDependencies() {
    arguments =
        ModalRoute.of(context)!.settings.arguments as PersonalChatArguments;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: BlocListener<SendMessageCubit, SendMessageState>(
                listener: (_, sendMessageState) {
                  if (sendMessageState is SendMessageSuccess) {
                    if (_isMessageEmpty) {
                      context.read<GetChatMessagesCubit>().retrieveChat(
                            arguments.otherUser.userId!,
                            arguments.myUser.userId!,
                          );

                      setState(() => _isMessageEmpty = false);
                    }
                  }
                },
                child: BlocBuilder<GetChatMessagesCubit, GetChatMessagesState>(
                  builder: (_, state) {
                    if (state is GetChatMessagesLoaded) {
                      scrollToBottom();
                      return _buildListMessage(
                        state.chats,
                      );
                    } else if (state is GetChatMessagesErrorOrEmpty) {
                      _isMessageEmpty = true;
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            ..._buildInputChat(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Material(
      elevation: 1,
      shadowColor: AppColors.backgroundOutlineColor.withOpacity(0.35),
      color: AppColors.whiteColor,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomNavigatorButton(
                icon: const Icon(Icons.arrow_back_ios, size: 18),
                onTap: () =>
                    Navigator.pushNamed(context, NamedRoutes.homeScreen),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                arguments.otherUser.name!,
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListMessage(
    List<MessageEntity> chats,
  ) =>
      ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 24, right: 24, top: 18),
        itemCount: chats.length,
        itemBuilder: (_, index) {
          final message = chats[index];
          final isMe = message.sendBy == arguments.myUser.userId;

          return ChatBubble(
            imgProfile: isMe
                ? arguments.myUser.imageProfile
                : arguments.otherUser.imageProfile,
            message: message.message,
            sendAt: message.sendAt,
            isMe: isMe,
          );
        },
      );

  List<Widget> _buildInputChat(BuildContext context) => [
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
              onTap: () {
                try {
                  _sendMessage(context, arguments.otherUser, arguments.myUser);
                } catch (e) {
                  CustomSnackBar.snackBar(context, "Opss.. Terjadi kesalahan");
                }
              },
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

  void _sendMessage(
      BuildContext context, MemberEntity userReceiver, MemberEntity myUser) {
    if (_messageTextController.text.isNotEmpty) {
      final message = MessageEntity(
        messageId: '',
        message: _messageTextController.text,
        sendBy: myUser.userId!,
        sendAt: Timestamp.now(),
      );

      context
          .read<SendMessageCubit>()
          .sendMessage(message, userReceiver, myUser);
      _messageTextController.clear();
    }
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
