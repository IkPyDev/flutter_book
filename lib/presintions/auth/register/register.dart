import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/register/register_bloc.dart';
import '../../../utils/ui/registration_button.dart';
import '../../../utils/ui/registration_field.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final retypePasswordController = TextEditingController();

    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.registerState == RegisterEnum.success) {
          Navigator.pushReplacementNamed(context, '/main');
        } else if (state.registerState == RegisterEnum.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
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
                          Text('Create an Account', style: textTheme.headlineMedium),
                          const SizedBox(height: 10),
                          Text(
                            'Register to continue',
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
                            context.read<RegisterBloc>().add(EmailChangeRegisterEvent(value));
                          },
                        ),
                        const SizedBox(height: 10),
                        RegistrationField(
                          controller: passwordController,
                          hintText: "Password",
                          onChanged: (value) {
                            context.read<RegisterBloc>().add(PasswordChangeRegisterEvent(value));
                          },
                        ),
                        const SizedBox(height: 10),
                        RegistrationField(
                          controller: retypePasswordController,
                          hintText: "Retype Password",
                          onChanged: (value) {
                            context.read<RegisterBloc>().add(RetypePasswordChangeRegisterEvent(value));
                          },
                        ),
                        const SizedBox(height: 20),
                        state.registerState != RegisterEnum.loading
                            ? RegistrationButton(
                          buttonText: 'REGISTER',
                          onClick: () {
                            context.read<RegisterBloc>().add(RegisterWithEmailEvent(
                              emailController.text,
                              passwordController.text,
                              retypePasswordController.text,
                            ));
                          },
                        )
                            : const SizedBox(
                          height: 48,
                          width: 48,
                          child: CircularProgressIndicator(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'or register using',
                          style: textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<RegisterBloc>().add(RegisterWithGoogleEvent());
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
                                context.read<RegisterBloc>().add(RegisterWithFacebookEvent());
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
                            text: 'Already have an account? ',
                            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.read<RegisterBloc>().add(ToLoginClickEvent());
                                    Navigator.pushReplacementNamed(context, '/login');
                                  },
                                text: 'Sign in',
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
