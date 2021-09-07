import 'dart:math' as math;

import 'package:flutter/material.dart';

/// 变换:
/// 1. Matrix4是一个4D矩阵。Matrix4.skewY(0.3), //沿Y轴倾斜 0.3弧度
/// 2. Transform.translate()
/// 3. Transform.rotate()
/// 4. Transform.scale()
/// 矩阵变化只会作用在绘制阶段
class TransformWidgetRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transform"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.green,
              child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: new Transform(
                    transform: new Matrix4.skewY(0.3),
                    alignment: Alignment.topRight,
                    child: new Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.deepOrange,
                      child: const Text("Apartment for rent!"),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                //默认原点为左上角，左移10像素，向上平移5像素
                child: Transform.translate(
                  offset: Offset(-10.0, -5.0),
                  child: Text("Hello world"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: Text("Hello World!"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Transform.scale(
                      scale: 1.5, //放大到1.5倍
                      child: Text("Hello world"))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                    child: Transform.scale(
                        scale: 1.5, child: Text("Hello world"))),
                Text(
                  "你好",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.green),
                  // RotatedBox是作用于layout阶段，所以子组件会旋转90度（而不只是绘制的内容）
                  child: RotatedBox(
                    quarterTurns: 1, //旋转90度
                    child: Text("Hello World!"),
                  ),
                ),
                Text(
                  "你好",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                )
              ],
            ),
            ContainerSampleWidget()
          ],
        ),
      ),
    );
  }
}

class ContainerSampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            //容器大小的限制条件。width、height优先级最高
            constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
            //背景装饰，和 color 属性互斥。
            decoration: BoxDecoration(
                //背景径向渐变
                gradient: RadialGradient(
                    colors: [Colors.red, Colors.orange],
                    center: Alignment.topLeft,
                    radius: 0.98),
                // 卡片阴影
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ]),
            //卡片倾斜变换
            transform: Matrix4.rotationZ(0.2),
            //卡片内文字居中
            alignment: Alignment.center,
            //卡片文字
            child: Text(
              "5.20",
              style: TextStyle(color: Colors.white, fontSize: 40.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40.0), //容器外补白
            color: Colors.orange,
            child: Text("Hello world!"),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.only(top: 10.0, right: 5.0), //容器内补白
            color: Colors.orange,
            child: Text("Hello world!"),
          ),
        ],
      ),
    );
  }
}
