import 'package:converse/auth/controller/auth_controller.dart';
import 'package:converse/common/widgets/cached_image.dart';
import 'package:converse/common/widgets/image_widgets.dart';
import 'package:converse/common/widgets/list_tile.dart';
import 'package:converse/common/widgets/text_widgets.dart';
import 'package:converse/common/widgets/theme_switcher.dart';
import 'package:converse/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

class UserProfileDrawerContent extends ConsumerWidget {
  const UserProfileDrawerContent({super.key});

  void navigateToUserProfileScreen(BuildContext context, String uId) {
    GoRouter.of(context).push('/u/$uId');
  }

  void logout(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Responsive(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: circleAvatar(
                    backgroundImage: cachedNetworkImageProvider(
                      url: user.avatar,
                    ),
                    radius: 65,
                  ),
                ),
                const SizedBox(height: 35),
                text20SemiBold(
                  context: context,
                  text: 'u/${user.name}',
                ),
                const SizedBox(height: 20),
                Divider(
                  color: Theme.of(context).cardColor,
                ),
                const SizedBox(height: 35),
                listTile(
                  title: text17SemiBold(
                    context: context,
                    text: "MY PROFILE",
                  ),
                  leading: SvgPicture.asset(
                    "assets/images/svgs/home/person.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hintColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () => isGuest
                      ? null
                      : navigateToUserProfileScreen(
                          context,
                          user.uid,
                        ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  tileColor: Theme.of(context).cardColor,
                ),
                const SizedBox(height: 25),
                listTile(
                  title: text17SemiBold(
                    context: context,
                    text: "LOGOUT",
                  ),
                  leading: SvgPicture.asset(
                    "assets/images/svgs/home/logout.svg",
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hintColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () => logout(ref),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  tileColor: Theme.of(context).cardColor,
                ),
                const SizedBox(height: 50),
                const ThemeSwitcher(),
                const SizedBox(height: 50),
                text20SemiBold(
                  context: context,
                  text: "Made with ❤️ by",
                ),
                const SizedBox(height: 10),
                Link(
                  uri: Uri.parse("https://github.com/sarthakz25"),
                  builder: (context, followLink) => GestureDetector(
                    onTap: followLink,
                    child: text20Heavy(
                      context: context,
                      text: "... .- .-. - .... .- -.-",
                    ),
                  ),
                  target: LinkTarget.self,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
