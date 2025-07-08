import 'package:demo_messenger/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(themeModeProvider);
    bool isDarkMode = darkMode == ThemeMode.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              _settingOption(
                context: context,
                icon: "assets/icons/language_icon.svg",
                title: "Language",
                options: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              _settingOption(
                context: context,
                icon: "assets/icons/darkMode_icon.svg",
                title: "Dark Mode",
                options: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    ref.read(themeModeProvider.notifier).state =
                    isDarkMode ? ThemeMode.light : ThemeMode.dark;
                  },
                  borderRadius: BorderRadius.circular(8), // Adds rounded ripple effect
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Transform.scale(
                      alignment: Alignment.center,
                      scale: 0.7,
                      child: SizedBox(
                        height: 10,
                        child: Switch.adaptive(
                          activeColor: Theme.of(context).colorScheme.primary,
                          inactiveThumbColor: Theme.of(context).colorScheme.onSurfaceVariant,
                          inactiveTrackColor: Theme.of(context).colorScheme.surfaceVariant,
                          value: isDarkMode,
                          onChanged: (value) {
                            ref.read(themeModeProvider.notifier).state =
                            value ? ThemeMode.dark : ThemeMode.light;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _settingOption(
                context: context,
                icon: "assets/icons/muteNotification_icon.svg",
                title: "Mute Notification",
                options: Transform.scale(
                  alignment: Alignment.center,
                  scale: 0.7,
                  child: SizedBox(
                    height: 10,
                    child: Switch.adaptive(
                      activeColor: Theme.of(context).colorScheme.primary,
                      inactiveThumbColor: Theme.of(context).colorScheme.onSurfaceVariant,
                      inactiveTrackColor: Theme.of(context).colorScheme.surfaceVariant,
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ),
              _settingOption(
                context: context,
                icon: "assets/icons/customNotification_icon.svg",
                title: "Custom Notification",
                options: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.outline,
              ),
              _settingOption(
                context: context,
                icon: "assets/icons/invite_icon.svg",
                title: "Invite Friends",
                options: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              _settingOption(
                context: context,
                icon: "assets/icons/group_icon.svg",
                title: "Joined Groups",
                options: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              _settingOption(
                context: context,
                icon: "assets/icons/hideChat_icon.svg",
                title: "Hide Chat History",
                options: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.scale(
                      alignment: Alignment.center,
                      scale: 0.7,
                      child: SizedBox(
                        height: 10,
                        child: Switch.adaptive(
                          activeColor: Theme.of(context).colorScheme.primary,
                          inactiveThumbColor: Theme.of(context).colorScheme.onSurfaceVariant,
                          inactiveTrackColor: Theme.of(context).colorScheme.surfaceVariant,
                          value: true,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 28,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              _settingOption(
                context: context,
                icon: "assets/icons/security_icon.svg",
                title: "Security",
                options: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.scale(
                      alignment: Alignment.center,
                      scale: 0.7,
                      child: SizedBox(
                        height: 10,
                        child: Switch.adaptive(
                          activeColor: Theme.of(context).colorScheme.primary,
                          inactiveThumbColor: Theme.of(context).colorScheme.onSurfaceVariant,
                          inactiveTrackColor: Theme.of(context).colorScheme.surfaceVariant,
                          value: true,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 28,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              _settingOption(
                context: context,
                icon: "assets/icons/termsOfService_icon.svg",
                title: "Terms of Service",
                options: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              _settingOption(
                context: context,
                icon: "assets/icons/aboutApp_icon.svg",
                title: "About App",
                options: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              _settingOption(
                context: context,
                icon: "assets/icons/helpCentre_icon.svg",
                title: "Help Centre",
                options: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              _settingOption(
                context: context,
                icon: "assets/icons/logout_icon.svg",
                title: "Logout",
                textColor: Theme.of(context).colorScheme.error,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _settingOption({
  required String icon,
  required String title,
  Widget? options,
  required BuildContext context,
  VoidCallback? onTap,
  Color? textColor,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: GestureDetector(
      onTap: onTap ?? () {},
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: SvgPicture.asset(
              icon,
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: textColor ?? Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          if (options != null) options,
        ],
      ),
    ),
  );
}