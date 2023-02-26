import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/domain/entities/chat_arguments.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:chatqu/presentation/widgets/card_row_item.dart';
import 'package:chatqu/presentation/widgets/custom_alert_dialog.dart';
import 'package:chatqu/presentation/widgets/header_screen.dart';
import 'package:chatqu/presentation/widgets/text_error_message.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({required this.myUser, Key? key}) : super(key: key);
  final UserEntity myUser;

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final TextEditingController _groupNameController = TextEditingController();
  File? _groupImage;
  bool _createChatGroupLoading = false;
  final List<UserEntity> _selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                SearchHeader(
                  title: "Teman",
                  hintSearchText: "Cari Pengguna",
                  onSearchTap: () {
                    context
                        .read<GetOwnRequestCubit>()
                        .getOwnRequests(widget.myUser.userId!);
                    Navigator.pushNamed(context, NamedRoutes.searchUserScreen);
                  },
                ),
                _buildFriendRequest(context),
                _buildFriendList(context),
                _buildCreateGroupListener()
              ],
            ),
          ),
          AnimatedPositioned(
            top: _selectedUsers.isNotEmpty ? pageHeight * 0.88 : pageHeight,
            left: pageWidth * 0.62,
            curve: Curves.easeInOutBack,
            duration: const Duration(milliseconds: 700),
            child: _buildCreateGroupButton(context),
          ),
        ],
      ),
    );
  }

  ListView _buildListFriends(
          BuildContext context, List<UserEntity> friends, UserEntity myUser) =>
      ListView.builder(
          itemCount: friends.length,
          padding: const EdgeInsets.only(bottom: 16),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            final friend = friends[index];

            return GestureDetector(
              onTap: () {
                if (_selectedUsers.isEmpty) {
                  context
                      .read<GetChatMessagesCubit>()
                      .retrieveChat(friend.userId!, myUser.userId!);

                  final personalChatArguments = PersonalChatArguments(
                    myUser: MemberEntity(
                      name: myUser.name,
                      userId: myUser.userId,
                      imageProfile: myUser.imageProfile,
                    ),
                    otherUser: MemberEntity(
                      name: friend.name,
                      userId: friend.userId,
                      imageProfile: friend.imageProfile,
                    ),
                  );

                  Navigator.pushNamed(context, NamedRoutes.personalChatScreen,
                      arguments: personalChatArguments);
                } else {
                  if (_selectedUsers.contains(friend)) {
                    setState(() =>
                        _selectedUsers.removeWhere((user) => user == friend));
                  } else {
                    setState(() => _selectedUsers.add(friend));
                  }
                }
              },
              onLongPress: () {
                if (!_selectedUsers.contains(friend)) {
                  setState(() => _selectedUsers.add(friend));
                }
              },
              child: CardRowItem(
                image: friend.imageProfile,
                title: friend.name!,
                subTitle: friend.username,
                isSelected: _selectedUsers.contains(friend),
              ),
            );
          });

  Widget _buildFriendRequest(BuildContext context) =>
      BlocBuilder<GetFriendRequestCubit, GetFriendRequestState>(
        builder: (context, state) {
          if (state is GetFriendRequestSuccess) {
            if (state.users.isNotEmpty) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  NamedRoutes.friendRequestsScreen,
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Permintaan Pertemanan",
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Anda memiliki permintaan pertemanan",
                            style: GoogleFonts.quicksand(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyTextColor,
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(6.5),
                        decoration: const BoxDecoration(
                          color: AppColors.redColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${state.users.length}",
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          } else {
            return const SizedBox();
          }
        },
      );

  Widget _buildFriendList(BuildContext context) => Expanded(
        child: BlocBuilder<GetAllFriendsCubit, GetAllFriendsState>(
          builder: (context, state) {
            if (state is GetAllFriendsSuccess) {
              return (state.users.isEmpty)
                  ? Center(
                      child: Text(
                        "Saat ini anda belum\nmemiliki teman",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                      ),
                    )
                  : _buildListFriends(
                      context,
                      state.users,
                      widget.myUser,
                    );
            } else if (state is GetAllFriendsFailure) {
              return const TextErrorMessage(
                  errorMessage: "Terjadi kesalahan coba lagi!");
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.blackColor,
                ),
              );
            }
          },
        ),
      );

  Widget _buildCreateGroupButton(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: ElevatedButton(
          onPressed: () => _showCreateGroupDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blackColor,
            fixedSize: Size(
              MediaQuery.of(context).size.width * 0.3,
              MediaQuery.of(context).size.height * 0.055,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, size: 24, color: AppColors.whiteColor),
              const SizedBox(width: 4),
              Text(
                "Group",
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      );

  Future _showCreateGroupDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _createGroupDialog(context),
    ).whenComplete(() {
      _groupImage = null;
      setState(() => _selectedUsers.clear());
    });
  }

  StatefulBuilder _createGroupDialog(BuildContext context) =>
      StatefulBuilder(builder: (context, setState) {
        return CustomAlertDialog(
          title: "Buat grup baru",
          contentHeight: MediaQuery.of(context).size.height * 0.5,
          content: [
            CustomTextFormField(
              hintText: "Masukkan nama grup anda",
              errorText: "Masukkan dengan benar nama grup anda",
              controller: _groupNameController,
            ),
            const SizedBox(height: 16),
            GestureDetector(
                onTap: () async {
                  await _pickImageFromGallery(setState);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: (_groupImage == null)
                        ? Border.all(color: AppColors.greyColor)
                        : null,
                    image: (_groupImage == null)
                        ? null
                        : DecorationImage(
                            image: FileImage(_groupImage!),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: (_groupImage == null)
                      ? Icon(
                          Icons.image_outlined,
                          color: AppColors.greyColor,
                          size: MediaQuery.of(context).size.height * 0.25,
                        )
                      : null,
                )),
            const SizedBox(height: 24),
            CustomButton(
              child: _createChatGroupLoading
                  ? const Center(
                      child: SizedBox(
                        height: 32,
                        width: 32,
                        child: CircularProgressIndicator(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    )
                  : Text(
                      "Buat grup",
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ),
              onTap: () async {
                if (_groupNameController.text.isNotEmpty &&
                    _groupImage != null &&
                    _selectedUsers.isNotEmpty) {
                  _selectedUsers.insert(0, widget.myUser);

                  setState(() => _createChatGroupLoading = true);
                  context.read<CreateGroupChatCubit>().createGroupChat(
                      _selectedUsers, _groupImage!, _groupNameController.text);
                }
              },
            ),
          ],
        );
      });

  Widget _buildCreateGroupListener() =>
      BlocListener<CreateGroupChatCubit, CreateGroupChatState>(
        listener: (context, snapshot) {
          if (snapshot is CreateGroupChatSuccess) {
            setState(() => _createChatGroupLoading = false);
            Navigator.pop(context);
            CustomSnackBar.snackBar(context, snapshot.successMessage);
          } else if (snapshot is CreateGroupChatError) {
            setState(() => _createChatGroupLoading = false);
            CustomSnackBar.snackBar(context, snapshot.errorMessage);
          }
        },
        child: const SizedBox(),
      );

  Future _pickImageFromGallery(Function setState) async {
    try {
      final image = await ManageImages.imageFromGallery();
      setState(() => _groupImage = File(image!.path));
    } catch (e) {
      debugPrint('ambil gambar error: $e');
    }
  }
}
