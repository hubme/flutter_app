import 'dart:ui';

import 'package:english_words/english_words.dart'; //https://pub.dev/packages/english_words
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LayoutRouter.dart';

void main() => runApp(MyApp());

// english_words 包使用示例
// void main() => syllables('beautiful'); //nouns.take(50).forEach(print);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        //注册首页路由
        "new_page": (context) => NewRoute(),
        "text_widget_page": (context) => TextWidgetRoute(),
        "button_widget_page": (context) => ButtonWidgetRoute(),
        "image_widget_page": (context) => ImageWidgetRoute(),
        "switch_checkbox_widget_page": (context) => SwitchAndCheckBoxRoute(),
        "textfield_widget_page": (context) => TextFieldAndFormRoute(),
        "layout_page": (context) => LayoutWidgetRoute(),
        "stack_positioned_page": (context) => StackPositionedRouter(),
        "align_alignment_page": (context) => AlignAlignmentRouter(),
        "constrained_layout_page": (context) => ConstrainedRouter(),
      },
      // onGenerateRoute 只会对命名路由生效。
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
          // 引导用户登录；其它情况则正常打开路由。
          print("aaa: $routeName");
          return null;
        });
      },
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  //当Widget第一次插入到Widget树时会被调用
  @override
  void initState() {
    super.initState();
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RandomWordsWidget(),
            TextButton(
              child: Text("Navigator"),
              onPressed: () {
                // MaterialPageRoute继承自PageRoute类，PageRoute类是一个抽象类，表示占有整个屏幕空间的一个模态路由页面
                // Navigator是一个路由管理的组件，它提供了打开和退出路由页方法。
                // 匿名路由
                /*Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return NewRoute();
                  },
                ));*/
                // 命名路由参数传值
                Navigator.of(context).pushNamed("new_page", arguments: "hello");
              },
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  final wordPair = new WordPair.random();
                  return TipRoute(text: "${wordPair.toString()}");
                }));
                print("路由返回值：$result");
              },
              child: Text("路由传值"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("text_widget_page");
                },
                child: Text("Text Widget")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("button_widget_page");
                },
                child: Text("Button Widget")),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("image_widget_page");
              },
              child: Text("Image Widget"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("switch_checkbox_widget_page");
              },
              child: Text("Switch And CheckBox Widget"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("textfield_widget_page");
              },
              child: Text("TextField Widget"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("layout_page");
              },
              child: Text("布局类组件"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  //当State对象的依赖发生变化时会被调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route。参数：$args"),
      ),
    );
  }
}

class TextWidgetRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Widget"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: [
              Text(
                "Hello World",
                textAlign: TextAlign.left,
              ),
              Text(
                "Hello World! I'm Jack." * 4,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Hello World!",
                textScaleFactor: 1.5,
              ),
              Text(
                "Hello World! I'm Jack." * 6,
                textAlign: TextAlign.center,
              ),
              Text(
                "Hello World",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    height: 1.2,
                    fontFamily: "Courier",
                    background: new Paint()..color = Colors.yellow,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(text: "Home: "),
                TextSpan(
                    text: "https://flutterchina.club",
                    style: TextStyle(color: Colors.blue)),
              ])),
              DefaultTextStyle(
                style: TextStyle(color: Colors.red, fontSize: 20.0),
                textAlign: TextAlign.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Hello World!"),
                    Text("Hello World!"),
                    Text(
                      "Hello World!",
                      style: TextStyle(inherit: false, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Text(
                "\uE914 \uE000 \uE90D \ue2eb \ue8d1 \ue287",
                // https://fonts.google.com/icons
                style: TextStyle(
                    fontFamily: "MaterialIcons",
                    fontSize: 24.0,
                    color: Colors.green),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.accessible,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.error,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.fingerprint,
                    color: Colors.green,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.green,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: 0.5,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      value: 0.8,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      value: 0.8,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: 0.5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Hello World, "), Text("I am Jack.")],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Hello World, "), Text("I am Jack.")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                textDirection: TextDirection.rtl,
                children: [Text("Hello World, "), Text("I am Jack.")],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                children: [
                  Text(
                    "Hello World, ",
                    style: TextStyle(fontSize: 30.0),
                  ),
                  Text("I am Jack.")
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("hi"),
                    Text("world"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  final String text;

  TipRoute({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: [
              Text("传递的值是：$text"),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(text);
                },
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonWidgetRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Button Widget")),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: [
              // RaisedButton 废弃
              ElevatedButton(
                child: Text("normal"),
                onPressed: () {},
              ),
              // FlatButton 废弃
              TextButton(
                child: Text("normal"),
                onPressed: () {},
              ),
              // OutlineButton 废弃
              OutlinedButton(
                child: Text("normal"),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImageWidgetRoute extends StatelessWidget {
  final image = AssetImage("images/beautiful_girl.jpg");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Widget"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: image,
              height: 50.0,
              width: 100.0,
              fit: BoxFit.fill,
            ),
            Image.asset(
              "images/beautiful_girl.jpg",
              width: 100.0,
            ),
            Image(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1615631150931-d15f51273758?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=332&q=80"),
              width: 100.0,
            ),
            Image(
              image: image,
              width: 100.0,
              color: Colors.blue,
              colorBlendMode: BlendMode.difference,
            ),
            Image(
              image: image,
              width: 100.0,
              height: 200.0,
              repeat: ImageRepeat.repeatY,
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchAndCheckBoxRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SwitchAndCheckBoxRouteState();
}

class _SwitchAndCheckBoxRouteState extends State<SwitchAndCheckBoxRoute> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = false; //维护复选框状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Switch And CheckBox Widget"),
      ),
      body: Column(
        children: [
          Switch(
              value: _switchSelected,
              onChanged: (value) {
                setState(() {
                  _switchSelected = value;
                });
              }),
          Checkbox(
              value: _checkboxSelected,
              tristate: true,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  _checkboxSelected = value;
                });
              })
        ],
      ),
    );
  }
}

class TextFieldAndFormRoute extends StatefulWidget {
  @override
  _TextFieldAndFormState createState() => _TextFieldAndFormState();
}

class _TextFieldAndFormState extends State<TextFieldAndFormRoute> {
  TextEditingController _unameController = TextEditingController();

  /*_unameController.text = "hello world!";
  _unameController.selection = TextSelection(
  baseOffset: 2, extentOffset: _unameController.text.length);*/

  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FocusNode focusNodeUser = new FocusNode();
    // 监听焦点变化
    focusNodeUser.addListener(() {
      print("用户名输入框焦点：${focusNodeUser.hasFocus}");
    });
    FocusNode focusNodePwd = new FocusNode();
    focusNodePwd.addListener(() {
      print("用户名输入框焦点：${focusNodePwd.hasFocus}");
    });
    FocusScopeNode focusScopeNode;

    return Theme(
        data: Theme.of(context).copyWith(
            hintColor: Colors.green[200],
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.green),
              hintStyle: TextStyle(color: Colors.green, fontSize: 14.0),
            )),
        child: Scaffold(
          appBar: AppBar(
            title: Text("TextField"),
          ),
          body: Column(
            children: [
              TextField(
                autofocus: true,
                focusNode: focusNodeUser,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "用户名或邮箱",
                    prefixIcon: Icon(Icons.person)),
                onChanged: (value) {
                  print("用户名 onChanged: $value");
                },
                controller: _unameController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登录密码",
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
                focusNode: focusNodePwd,
                onChanged: (value) {
                  print("密码 onChanged: $value");
                },
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "请输入用户名",
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              ElevatedButton(
                child: Text("移动焦点"),
                onPressed: () {
                  //将焦点从第一个TextField移到第二个TextField
                  // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                  // 这是第二种写法
                  if (null == focusScopeNode) {
                    focusScopeNode = FocusScope.of(context);
                  }
                  focusScopeNode.requestFocus(focusNodePwd);
                },
              ),
              ElevatedButton(
                child: Text("隐藏键盘"),
                onPressed: () {
                  // 当所有编辑框都失去焦点时键盘就会收起
                  focusNodeUser.unfocus();
                  focusNodePwd.unfocus();
                },
              ),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        controller: _unameController,
                        decoration: InputDecoration(
                            labelText: "用户名",
                            hintText: "用户名和邮箱",
                            icon: Icon(Icons.person)),
                        validator: (value) {
                          return value.trim().length > 0 ? null : "用户名不能为空";
                        },
                      ),
                      TextFormField(
                        controller: _pwdController,
                        decoration: InputDecoration(
                            labelText: "密码",
                            hintText: "登录密码",
                            icon: Icon(Icons.lock)),
                        obscureText: true,
                        validator: (value) {
                          return value.trim().length > 5 ? null : "密码不能少于 6 位";
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              child: Text("登录"),
                              onPressed: () {
                                if ((_formKey.currentState as FormState)
                                    .validate()) {
                                  print("验证通过提交数据");
                                }
                              },
                            ))
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}

