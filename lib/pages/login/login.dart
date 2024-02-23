import 'package:converse/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:converse/theme/palette.dart';
import 'package:converse/common/widgets/button_widgets.dart';
import 'package:converse/common/widgets/text_widgets.dart';
import 'package:converse/common/widgets/app_bar.dart';
import 'package:converse/common/widgets/app_textfield.dart';
import 'package:converse/pages/login/widgets.dart';
import 'package:converse/common/widgets/loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

final passwordVisibleStateProvider = StateProvider<bool>((ref) {
  return true;
});

class Login extends ConsumerWidget {
  const Login({super.key});

  // void loginHandler() {
  //   print("login");
  // }

  void guestSignIn(
    WidgetRef ref,
    BuildContext context,
  ) {
    ref.read(authControllerProvider.notifier).guestSignIn(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLightTheme =
        Theme.of(context).colorScheme.brightness == Brightness.light;

    final isLoading = ref.watch(authControllerProvider);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Scaffold(
            appBar: buildAppbar(
              context: context,
              bottom: true,
              actions: [
                iconButton(
                  onPressed: () => guestSignIn(
                    ref,
                    context,
                  ),
                  icon: SvgPicture.asset(
                    "assets/images/svgs/register/guest.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hintColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  padding: const EdgeInsets.only(right: 15),
                ),
              ],
              title: text24Medium(context: context, text: "Welcome Back"),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // top login buttons
                      thirdPartyLogin(context, ref),
                      // more login option message
                      Center(
                        child: text16Regular(
                          context: context,
                          text: "Or use your email account login",
                        ),
                      ),
                      // spacing
                      const SizedBox(height: 65),
                      // email text box
                      AppTextField(
                        text: "Email Address",
                        iconName: "assets/images/svgs/register/mail.svg",
                        hintText: "Enter your email address",
                        isPasswordField: false,
                        func: (value) {},
                      ),
                      // spacing
                      const SizedBox(height: 35),
                      // password text box
                      AppTextField(
                        text: "Password",
                        iconName: "assets/images/svgs/register/lock.svg",
                        hintText: "Enter your password",
                        isPasswordField: true,
                        func: (value) {},
                        obscureTextProvider: passwordVisibleStateProvider,
                      ),
                      // spacing
                      const SizedBox(height: 35),
                      // forgot password text
                      Container(
                        width: 345,
                        alignment: Alignment.centerRight,
                        child: textUnderline(
                          text: "Forgot Password?",
                          color: isLightTheme
                              ? Palette.darkBlue
                              : Palette.lightBlue,
                        ),
                      ),
                      // spacing
                      const SizedBox(height: 85),
                      // app login button
                      Center(
                        child: appButton(
                          context: context,
                          buttonName: "LOGIN",
                        ),
                      ),
                      const SizedBox(height: 25),
                      // app signup button
                      Center(
                        child: appButton(
                          context: context,
                          buttonName: "SIGN UP",
                          isLogin: false,
                          func: () => GoRouter.of(context).pushNamed('signup'),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isLoading) const Loader(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
