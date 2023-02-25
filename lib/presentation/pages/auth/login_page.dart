import 'package:chatqu/app/configs/colors.dart';
import 'package:chatqu/app/resources/named_routes.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _onRememberMe = false;
  final _formKey = GlobalKey<FormState>();
  late bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 24, right: 24, top: 64),
        children: [
          ..._buildHeader(),
          _buildLoginForm(),
          const SizedBox(height: 32),
          _buildRememberMe(),
          const SizedBox(height: 32),
          _buildLoginButton(),
          const SizedBox(height: 24),
          ..._buildLoginOption(),
        ],
      ),
    );
  }

  Row _buildRememberMe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: _onRememberMe,
            onChanged: (value) {
              setState(() => _onRememberMe = value!);
            },
            checkColor: AppColors.whiteColor,
            activeColor: AppColors.blackColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          "Ingat saya",
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }

  Form _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: "Email",
            errorText: "Error",
            controller: _emailController,
          ),
          const SizedBox(height: 32),
          CustomTextFormField(
            hintText: "Password",
            errorText: "Error",
            obscureText: true,
            controller: _passwordController,
          ),
        ],
      ),
    );
  }

  _buildHeader() => [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Masuk ke akun\nanda",
            textAlign: TextAlign.start,
            style: GoogleFonts.quicksand(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(
              width: 87,
              height: 4,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              width: 8,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
      ];

  Widget _buildLoginButton() => CustomButton(
        child: BlocListener<SignInUserCubit, SignInUserState>(
          listener: (context, state) {
            if (state is SignInUserLoaded) {
              setState(() => _isLoading = false);
              if (state.user.userId != "") {
                _loginBlocSinkInput(state.user.userId!);

                Navigator.pushReplacementNamed(context, NamedRoutes.homeScreen);
              }
            } else if (state is SignInUserError) {
              setState(() => _isLoading = false);
              CustomSnackBar.snackBar(context, state.message);
            } else if (state is SignInUserLoading) {
              setState(() => _isLoading = true);
            }
          },
          child: _isLoading
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
                  'Masuk',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
                ),
        ),
        onTap: () => _onLogin(),
      );

  List<Widget> _buildLoginOption() => [
        Text(
          'Atau',
          textAlign: TextAlign.center,
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.greyTextColor,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Masuk dengan Google',
          textAlign: TextAlign.center,
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 84),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya akun? ',
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.greyTextColor,
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, NamedRoutes.registerScreen),
              child: Text(
                "Daftar",
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greenColor,
                ),
              ),
            )
          ],
        ),
      ];

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      context.read<SignInUserCubit>().signInUser(email, password);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginBlocSinkInput(String myUserId) {
    context.read<GetUserDataCubit>().getUser(myUserId);
    context.read<CurrentUserIdCubit>().getCurrentUserId();
    context.read<GetFriendRequestCubit>().getFriendRequests(myUserId);
    context.read<GetAllFriendsCubit>().getAllFriends(myUserId);
    context.read<GetOwnRequestCubit>().getOwnRequests(myUserId);
    context.read<GetAllChatCubit>().getAllChat(myUserId);
  }
}
