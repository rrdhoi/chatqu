import 'package:chatqu/app/app.dart';
import 'package:chatqu/app/utils/manage_images.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:flutter/material.dart';

class AddImageProfilePage extends StatefulWidget {
  const AddImageProfilePage({Key? key}) : super(key: key);

  @override
  State<AddImageProfilePage> createState() => _AddImageProfilePageState();
}

class _AddImageProfilePageState extends State<AddImageProfilePage> {
  File? _image;
  late String myUserId;

  @override
  void didChangeDependencies() {
    final String argument =
        ModalRoute.of(context)!.settings.arguments as String;
    myUserId = argument;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () async => _pickImage(userId),
              child: SizedBox(
                width: _image != null ? 140 : 152,
                height: 140,
                child: Stack(
                  children: [
                    _image != null
                        ? SizedBox(
                            width: 140,
                            height: 140,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Image.file(
                                _image!,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Image.asset(
                            AssetsPath.icAddProfile,
                            width: 140,
                          ),
                    _image != null
                        ? const SizedBox()
                        : Positioned(
                            left: 115,
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                AssetsPath.icCamera,
                                width: 40,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Tambahkan Foto Profil',
              style: GoogleFonts.quicksand(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Lengkapi profil kamu dengan \nmenambahkan foto profil',
              style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.greyTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 70),
            SizedBox(
              width: 220,
              child: CustomButton(
                onTap: () => _uploadImage(userId),
                child: BlocListener<UploadImageProfileCubit,
                    UploadImageProfileState>(
                  listener: (_, state) {
                    if (state is UploadImageProfileSuccess) {
                      _addProfileBlocSinkInput(myUserId);
                      Navigator.pushReplacementNamed(
                          context, NamedRoutes.homeScreen);
                    }
                  },
                  child: BlocBuilder<UploadImageProfileCubit,
                      UploadImageProfileState>(builder: (_, state) {
                    if (state is UploadImageProfileFailure) {
                      debugPrint('error ::: ${state.message}');
                    }

                    if (state is UploadImageProfileLoading) {
                      return const Center(
                        child: SizedBox(
                          height: 32,
                          width: 32,
                          child: CircularProgressIndicator(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      );
                    } else {
                      return Text(
                        'Lanjutkan',
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      );
                    }
                  }),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _pickImage(String userId) async {
    try {
      final image = await ManageImages.imageFromGallery();
      File? compressedImage =
          await ManageImages.imageCompress(File(image!.path), userId);
      setState(() {
        _image = compressedImage;
      });
    } catch (e) {
      debugPrint('ambil gambar error: $e');
    }
  }

  void _uploadImage(String userId) {
    if (_image != null) {
      context
          .read<UploadImageProfileCubit>()
          .uploadImageProfile(_image!, userId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image'),
        ),
      );
    }
  }

  void _addProfileBlocSinkInput(String myUserId) {
    context.read<GetUserDataCubit>().getUser(myUserId);
    context.read<GetFriendRequestCubit>().getFriendRequests(myUserId);
    context.read<GetAllFriendsCubit>().getAllFriends(myUserId);
    context.read<GetOwnRequestCubit>().getOwnRequests(myUserId);
    context.read<GetAllChatCubit>().getAllChat(myUserId);
  }
}
