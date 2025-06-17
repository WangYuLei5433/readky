import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leadingIcon;
  final void Function()? onPressedLeading;
  final List<Widget>? actions;

  CustomAppBar({
    this.title,
    this.leadingIcon,
    this.onPressedLeading,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 23, 96, 173),
      elevation: 0.0,
      centerTitle: true,
      title: title,
      leading: (leadingIcon != null)
          ? IconButton(
              icon: leadingIcon!,
              onPressed: onPressedLeading,
            )
          : null,
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}
