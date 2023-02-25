import 'package:chatqu/app/configs/colors.dart';
import 'package:chatqu/app/resources/named_routes.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 24, right: 24, top: 64),
        children: [
          ..._buildHeader(),
          _buildRegisterForm(),
          const SizedBox(height: 32),
          CustomButton(
            child: BlocListener<SignUpUserCubit, SignUpUserState>(
              listener: (context, state) {
                if (state is SignUpUserLoaded) {
                  Navigator.pushNamed(
                      context, NamedRoutes.addImageProfileScreen,
                      arguments: state.user.userId);
                }
              },
              child: BlocBuilder<SignUpUserCubit, SignUpUserState>(
                  builder: (_, state) {
                if (state is SignUpUserError) {
                  debugPrint("Register ::: ${state.message}");
                }

                if (state is SignUpUserLoading) {
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
                    'Daftar',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  );
                }
              }),
            ),
            onTap: () => onRegister(),
          ),
          const SizedBox(height: 24),
          _buildRegisterOption(),
        ],
      ),
    );
  }

  Form _buildRegisterForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: "Nama",
            errorText: "Error",
            controller: _nameController,
          ),
          const SizedBox(height: 32),
          CustomTextFormField(
            hintText: "Username",
            errorText: "Error",
            controller: _usernameController,
          ),
          const SizedBox(height: 32),
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
            "Buat akun baru\nanda",
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

  _buildRegisterOption() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sudah punya akun? ',
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.greyTextColor,
            ),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pushNamed(context, NamedRoutes.loginScreen),
            child: Text(
              "Masuk",
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.greenColor,
              ),
            ),
          )
        ],
      );

  void onRegister() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final username = _usernameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      final user = UserEntity(
        userId: "",
        name: name,
        username: username,
        email: email,
      );
      context.read<SignUpUserCubit>().signUpUser(user, password);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}
