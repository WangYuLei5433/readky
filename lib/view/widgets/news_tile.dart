import 'package:flutter/material.dart';
import 'package:digital_omamori/model/core/news.dart';
import 'package:digital_omamori/route/slide_page_route.dart';
import 'package:digital_omamori/view/screens/news_detail_page.dart';
import 'package:digital_omamori/view/widgets/safe_network_image.dart'; // ✅ 引入图片组件

class NewsTile extends StatelessWidget {
  final News data;
  NewsTile({required this.data});

  @override
  Widget build(BuildContext context) {
    final double imageSize = 84;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          SlidePageRoute(child: NewsDetailPage(data: data)),
        );
      },
      child: Container(
        height: imageSize,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SafeNetworkImage(
                url: data.photo ?? '',
                width: imageSize,
                height: imageSize,
                fallbackAsset: 'assets/icons/newpaper-squire.png',
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 16 - 16 - imageSize,
              padding: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      fontFamily: 'inter',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    data.description ?? '',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
