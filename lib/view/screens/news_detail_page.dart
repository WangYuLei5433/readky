import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:digital_omamori/model/core/news.dart';
import 'package:digital_omamori/view/widgets/custom_app_bar.dart';

class NewsDetailPage extends StatelessWidget {
  final News data;
  NewsDetailPage({required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        onPressedLeading: () {},
        title: SvgPicture.asset('assets/icons/appname.svg'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/Bookmark.svg',
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5),
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          if (data.photo?.isNotEmpty ?? false)
            Container(
              width: screenWidth,
              height: 240,
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(data.photo!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data.date} | ${data.author}',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6), fontSize: 12),
                ),
                SizedBox(height: 12),
                Text(
                  data.title ?? '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                Html(
                  data: data.description ?? '',
                  style: {
                    'body': Style(
                        fontSize: FontSize(14),
                        lineHeight: LineHeight(1.5),
                        color: Colors.black87),
                    'a': Style(
                        color: Colors.blue,
                        textDecoration: TextDecoration.underline),
                  },
                  // 点击链接即可跳转
                  onLinkTap: (String? url, _, __) async {
                    if (url == null) return;
                    final uri = Uri.tryParse(url);
                    if (uri != null && await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  extensions: [
                    TagExtension(
                      tagsToExtend: {'img'},
                      builder: (context) {
                        final src = context.element?.attributes['src'] ?? '';
                        if (src.isEmpty) return SizedBox.shrink();
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(src,
                                width: screenWidth - 32, fit: BoxFit.cover),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
