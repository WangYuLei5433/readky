import 'package:flutter/material.dart';
import 'package:digital_omamori/model/core/news.dart';
import 'package:digital_omamori/route/slide_page_route.dart';
import 'package:digital_omamori/view/screens/news_detail_page.dart';
import 'package:digital_omamori/view/widgets/safe_network_image.dart'; // ✅ 记得导入图片组件

class BreakingNewsCard extends StatelessWidget {
  final News data;
  BreakingNewsCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          SlidePageRoute(child: NewsDetailPage(data: data)),
        );
      },
      child: Container(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeNetworkImage(
              url: data.photo ?? '',
              width: 200,
              height: 120,
              borderRadius: 10,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  data.title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    fontFamily: 'inter',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
