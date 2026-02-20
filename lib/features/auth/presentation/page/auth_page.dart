import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:search_frontend/core/utils/responsive.dart';
import 'package:search_frontend/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:search_frontend/features/auth/presentation/cubit/auth_state.dart';
import 'package:search_frontend/features/auth/presentation/widgets/bottom_info.dart';
import 'package:search_frontend/features/auth/presentation/widgets/sign_in_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          context.goNamed("node", pathParameters: {"nodeId": "root"});
        }
        if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${state.message}-${state.errorCode}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (!Responsive.isMobile(context))
                Expanded(flex: 1, child: SizedBox.shrink()),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    SignInForm(),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomInfo(),
                    ),
                  ],
                ),
              ),
              if (!Responsive.isMobile(context))
                Expanded(flex: 1, child: SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
