import 'package:book_app/domain/local/pref_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../utils/ui/registration_button.dart';
import '../../../utils/ui/registration_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginState == LoginEnum.success) {
          PrefHelper.setIsLoggedIn(true);
          Navigator.pushReplacementNamed(context, '/main');
        } else if (state.loginState == LoginEnum.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 45,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/bg_splash.png'),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/images/logo1.png'),
                          const SizedBox(height: 20),
                          Text('Welcome back', style: textTheme.headlineMedium),
                          const SizedBox(height: 10),
                          Text(
                            'Sign in to continue',
                            style: textTheme.headlineSmall?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 55,
                    child: Column(
                      children: [
                        RegistrationField(
                          controller: emailController,
                          hintText: "Email Address",
                          onChanged: (value) {
                            context.read<LoginBloc>().add(EmailChangeLoginEvent(value));
                          },
                        ),
                        const SizedBox(height: 10),
                        RegistrationField(
                          controller: passwordController,
                          hintText: "Password",
                          onChanged: (value) {
                            context.read<LoginBloc>().add(PasswordChangeLoginEvent(value));
                          },
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              context.read<LoginBloc>().add(ForgetPasswordClickEvent());
                            },
                            child: Text(
                              'Forgot Password?',
                              style: textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                        state.loginState != LoginEnum.loading
                            ? RegistrationButton(
                          buttonText: 'SIGN IN',
                          onClick: () {
                            context.read<LoginBloc>().add(LoginWithEmailEvent());
                          },
                        )
                            : const SizedBox(
                          height: 48,
                          width: 48,
                          child: CircularProgressIndicator(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'or sign in using',
                          style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<LoginBloc>().add(LoginWithGoogleEvent());
                              },
                              child: Image.asset(
                                'assets/images/google.png',
                                height: 36,
                                width: 36,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                context.read<LoginBloc>().add(LoginWithFacebookEvent());
                              },
                              child: Image.asset(
                                'assets/images/facebook.png',
                                height: 36,
                                width: 36,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            text: 'Do not have an account? ',
                            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.read<LoginBloc>().add(ToRegisterClickEvent());
                                  },
                                text: 'Register',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
