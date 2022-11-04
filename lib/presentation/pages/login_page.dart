import 'package:chatqu/app/configs/colors.dart';
import 'package:chatqu/app/resources/named_routes.dart';
import 'package:chatqu/presentation/bloc/user/current_user_id/current_user_id_cubit.dart';
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
          CustomButton(
              child: BlocListener<SignInUserCubit, SignInUserState>(
                listener: (context, state) {
                  if (state is SignInUserLoaded) {
                    context.read<CurrentUserIdCubit>().getCurrentUserId();
                    context.read<GetAllChatCubit>().getAllChat();
                    context
                        .read<GetUserDataCubit>()
                        .getUser(state.user.userId!);
                    Navigator.pushNamed(context, NamedRoutes.homeScreen);
                  }
                },
                child: BlocBuilder<SignInUserCubit, SignInUserState>(
                  builder: (context, state) {
                    if (state is SignInUserError) {
                      debugPrint("Login ::: ${state.message}");
                    }

                    if (state is SignInUserLoading) {
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
                        'Masuk',
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      );
                    }
                  },
                ),
              ),
              onTap: () => _onLogin()),
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

  _buildLoginOption() => [
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
}
