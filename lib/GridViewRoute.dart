import 'package:flutter/material.dart';

class GridViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView"),
      ),
      body: _Sample3(),
    );
  }
}

/*
  SliverGridDelegateWithFixedCrossAxisCount({
    // 横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，即ViewPort横轴长度除以crossAxisCount的商。
    @required double crossAxisCount,
    // 主轴方向的间距
    double mainAxisSpacing = 0.0,
    // 横轴方向子元素的间距
    double crossAxisSpacing = 0.0,
    // 子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度
    double childAspectRatio = 1.0,
  })
 */
class _Sample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, //横轴三个子widget
            childAspectRatio: 2.0 //子 widget 的宽高比
            ),
        children: <Widget>[
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast)
        ]);
  }
}

/*
  SliverGridDelegateWithMaxCrossAxisExtent({
    // 子元素在横轴上的最大长度
    double maxCrossAxisExtent,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
  })
 */
class _Sample2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120.0, childAspectRatio: 2.0),
      children: [
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ],
    );*/
    // 同
    return GridView.extent(
      maxCrossAxisExtent: 120.0,
      childAspectRatio: 2.0,
      children: [
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    );
  }
}

class _Sample3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Sample3State();
}

class _Sample3State extends State<_Sample3> {
  List<IconData> _icons = [];

  @override
  void initState() {
    super.initState();
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.0),
      itemBuilder: (context, index) {
        if (index == _icons.length - 1 && _icons.length < 49) {
          _retrieveIcons();
        }
        return Icon(_icons[index]);
      },
      itemCount: _icons.length,
    );
  }

  void _retrieveIcons() {
    Future.delayed(Duration(microseconds: 200)).then((value) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}
