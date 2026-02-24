import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:search_frontend/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:search_frontend/features/auth/presentation/cubit/auth_state.dart';

import '../../../../core/constants/index.dart';
import '../../../../core/utils/index.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      height: SizeConfig.screenHeight - 100,
      constraints: BoxConstraints(maxWidth: 1000, maxHeight: 600),
      decoration: BoxDecoration(
        boxShadow: AppShadows.elevated(elevation: 4, offset: Offset(4, 4)),

        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context)) ...[
            Flexible(
              child: Lottie.asset(
                "assets/signInLogo.json",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
          ],
          Container(
            constraints: BoxConstraints(maxWidth: 360),
            padding: EdgeInsets.all(AppPadding.large),
            decoration: BoxDecoration(
              boxShadow: AppShadows.elevated(),

              // border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(AppRadius.medium),
              color: Theme.of(context).colorScheme.surfaceContainerLow,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/logo.png",
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Вход в учетную запись",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: SizeConfig.blockSizeVertical),
                  Text(
                    "Табельный номер",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: AppPadding.extraSmall),
                  TextField(controller: loginController),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  Text(
                    "Пароль",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: AppPadding.extraSmall),

                  TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () => setState(() {
                          _obscurePassword = !_obscurePassword;
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 3),
                  Row(
                    children: [
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return Expanded(
                            child: FilledButton(
                              onPressed: state.status == AuthStatus.loading
                                  ? null
                                  : () {
                                      context.read<AuthCubit>().login(
                                        loginController.text.trim(),
                                        passwordController.text.trim(),
                                      );
                                    },
                              style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.small,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.small,
                                ),

                                child:
                                    // state.status == AuthStatus.loading
                                    // ? CircularProgressIndicator()
                                    // :
                                    Text(
                                      'Войти',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                          ),
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
