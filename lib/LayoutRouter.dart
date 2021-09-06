import 'package:flutter/material.dart';

/*
线性布局：Row Column
弹性布局：Flex
流式布局：Wrap Flow
层叠布局：Stack Positioned
对齐与相对定位：Align
指定子组件的长宽比：AspectRatio
指定最大宽高：LimitedBox
根据父容器宽高的百分比来设置子组件宽高：FractionallySizedBox
装饰容器：DecoratedBox
 */
class LayoutWidgetRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Layout Widget"),
      ),
      body: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Container(
                  height: 30.0,
                  color: Colors.red,
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 30.0,
                  color: Colors.green,
                ),
                flex: 2,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              height: 100.0,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    child: Container(
                      height: 30.0,
                      color: Colors.red,
                    ),
                    flex: 2,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      height: 30.0,
                      color: Colors.green,
                    ),
                    flex: 1,
                  )
                ],
              ),
            ),
          ),
          Wrap(
            spacing: 28.0, // 主轴(水平)方向间距
            runSpacing: 10.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: [
              Chip(
                label: Text("Hamilton"),
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("A"),
                ),
              ),
              Chip(
                avatar: CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('M')),
                label: Text('Lafayette'),
              ),
              Chip(
                avatar: CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('H')),
                label: Text('Mulligan' * 3),
              ),
              Chip(
                avatar: CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('J')),
                label: Text('Laurens Laurens'),
              ),
            ],
          ),
          Flow(
            delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
            children: <Widget>[
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.red,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.green,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.blue,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.yellow,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.brown,
              ),
              new Container(
                width: 80.0,
                height: 80.0,
                color: Colors.purple,
              ),
            ],
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("stack_positioned_page");
              },
              child: Text("Stack 和 Positioned 布局容器")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("align_alignment_page");
              },
              child: Text("Align 和 Alignment 布局容器")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("constrained_layout_page");
              },
              child: Text("尺寸限制类容器"))
        ],
      ),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  getSize(BoxConstraints constraints) {
    //指定Flow的大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

class StackPositionedRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack And Positioned"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          // fit: StackFit.expand,
          children: [
            Container(
              child: Text(
                "Hello World!",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
            Positioned(
              child: Text("I am Jack."),
              left: 18.0,
            ),
            Positioned(
              child: Text("Your friend."),
              top: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}

class AlignAlignmentRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Align And Alignment"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              color: Colors.blue[50],
              child: Align(
                alignment: Alignment.topRight,
                child: FlutterLogo(
                  size: 60,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: 120.0,
                width: 120.0,
                color: Colors.blue[50],
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: 200.0,
                width: 100.0,
                color: Colors.blue[50],
                child: Align(
                  // 以矩形的中心点作为坐标原
                  // x、y的值从-1到1分别代表矩形左边到右边的距离和顶部到底边的距离
                  // (Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)
                  alignment: Alignment(2.0, 0.0),
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: 100.0,
                width: 100.0,
                color: Colors.blue[50],
                child: Align(
                  // 缩放因子，会分别乘以子元素的宽、高
                  widthFactor: 2,
                  heightFactor: 2,
                  // 以矩形的中心点作为坐标原
                  // x、y的值从-1到1分别代表矩形左边到右边的距离和顶部到底边的距离
                  // (Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)
                  alignment: Alignment.centerRight,
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0),
              child: Container(
                height: 120.0,
                width: 120.0,
                color: Colors.blue[50],
                child: Align(
                  alignment: FractionalOffset(0.2, 0.5),
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
            ),
            Container(
              width: 100.0,
              height: 100.0,
              color: Colors.green,
              child: Center(
                child: Text("Hello"),
                widthFactor: 1,
                heightFactor: 1,
              ),
            )
          ],
        ));
  }
}

class ConstrainedRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget greenBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.green),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("尺寸限制类容器"),
        actions: [
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
                // BoxConstraints.tight(Size(50.0, 50.0))
                // BoxConstraints.expand()
                constraints: BoxConstraints(
                    minWidth: double.infinity, //宽度尽可能大
                    minHeight: 50.0 //最小高度为50像素
                    ),
                child: greenBox),
            SizedBox(width: 80.0, height: 80.0, child: greenBox),
            DecoratedBox(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.red, Colors.orange[700]]),
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0)
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
