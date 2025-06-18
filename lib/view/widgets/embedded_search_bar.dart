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
  // 1760AD-inspired color palette
  final Color primaryColor = const Color(0xFF1760AD); // 主色调
  final Color accentColor = const Color.fromARGB(255, 53, 139, 192); // 辅助色
  final Color textColor = const Color(0xFF002B5B); // 文字颜色
  final Color hintColor = const Color(0xFF7A9CC6); // 提示文字颜色
  final Color backgroundColor = const Color(0xFFF4F9F9); // 背景色
  final Color borderColor = const Color(0xFFD1E0EB); // 新增边框颜色

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all( // 添加明显边缘
          color: borderColor,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              cursorColor: primaryColor, // 光标颜色与按钮一致
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              onChanged: (value) {
                setState(() {});
              },
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none, // 聚焦时保持无边框
                enabledBorder: InputBorder.none, // 非聚焦时保持无边框
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
                prefixIconConstraints: BoxConstraints(maxHeight: 20),
                hintText: 'Search...',
                hintStyle: TextStyle(
                  color: hintColor,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          // Search/Cancel button
          Container(
            margin: EdgeInsets.only(right: 4),
            child: ElevatedButton(
              onPressed: widget.controller.text.isEmpty
                  ? () {
                      widget.controller.clear();
                      FocusScope.of(context).unfocus();
                      setState(() {});
                    }
                  : widget.onSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                minimumSize: Size(0, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 0,
              ),
              child: Text(widget.controller.text.isEmpty ? 'Search' : 'Search'),
            ),
          ),
        ],
      ),
    );
  }
}