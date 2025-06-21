import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmbeddedSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const EmbeddedSearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  _EmbeddedSearchBarState createState() => _EmbeddedSearchBarState();
}

class _EmbeddedSearchBarState extends State<EmbeddedSearchBar> {
  final Color primaryColor = const Color(0xFF1760AD);
  final Color accentColor = const Color.fromARGB(255, 53, 139, 192);
  final Color textColor = const Color(0xFF002B5B);
  final Color hintColor = const Color(0xFF7A9CC6);
  final Color backgroundColor = const Color(0xFFF4F9F9);
  final Color borderColor = const Color(0xFFD1E0EB);

  bool isInputEmpty = true;

  @override
  void initState() {
    super.initState();
    // 监听输入框文字变化
    widget.controller.addListener(() {
      setState(() {
        isInputEmpty = widget.controller.text.trim().isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionColor: primaryColor.withOpacity(0.3),
          selectionHandleColor: primaryColor,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 23, bottom: 4),
        height: 48,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                onSubmitted: (_) {
                  if (!isInputEmpty) {
                    widget.onSearch();
                  }
                },
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  prefixIcon: Visibility(
                    visible: widget.controller.text.isEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: SvgPicture.asset(
                        'assets/icons/Search.svg',
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          hintColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(maxHeight: 20),
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: hintColor,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 4),
              child: ElevatedButton(
                onPressed: isInputEmpty
                    ? () {
                        FocusScope.of(context).unfocus(); // 输入为空时收起键盘
                      }
                    : widget.onSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  minimumSize: const Size(0, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: const Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
