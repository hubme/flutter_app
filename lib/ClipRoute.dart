import 'package:flutter/material.dart';

/*
* Flutter中提供了一些剪裁函数，用于对组件进行剪裁。
*
* ClipOval: 子组件为正方形时剪裁为内贴圆形，为矩形时，剪裁为内贴椭圆
* ClipRRect: 将子组件剪裁为圆角矩形
* ClipRect: 剪裁子组件到实际占用的矩形大小（溢出部分剪裁）
*/
class ClipRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset("images/beautiful_girl.jpg", width: 80.0);

    return Scaffold(
      appBar: AppBar(
        title: Text("裁剪"),
      ),
      body: Center(
        child: Column(
          children: [
            avatar,
            ClipOval(child: avatar), //剪裁为圆形
            //剪裁为圆角矩形
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: avatar,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.5, //宽度设为原来宽度一半，另一半会溢出
                  child: avatar,
                ),
                Text(
                  "Hello World!",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //将溢出部分剪裁
                ClipRect(
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: 0.5, //宽度设为原来宽度一半
                    child: avatar,
                  ),
                ),
                Text(
                  "Hello World!",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: ClipRect(
                  clipper: _MyClipper(), //使用自定义的clipper
                  child: avatar),
            )
          ],
        ),
      ),
    );
  }
}

class _MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(
      0, 50.0, 100.0, 20.0); //Rect.fromLTWH(220.0, 310.0, 320.0, 410.0);

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}
