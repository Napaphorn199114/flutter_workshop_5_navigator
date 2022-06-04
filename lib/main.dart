import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _route = <String, WidgetBuilder>{
    '/page1': (BuildContext context) => MyApp(),
    '/page2': (BuildContext context) => Page2(),
    '/page3': (BuildContext context) => Page3(
          user: User(""),
          text: '',
        ),
    '/page4': (BuildContext context) => Page4(),
  };

  //App: page1(myapp) -> page2 ->page3 -> ...
  //Navigator.pushNamed(context,routeName)   Next
  //Navigator.pop(context);                  Back

  //App:page1(login) ->page2 ->page4 ->...
  //Navigator.pushReplacementNamed(context,routeName)  push แบบแทนที่ของเก่า
  //Navigator.popAndPushName(context,routeName)

  //App:page1(login*) ->page2 ->page3 ->page4(logout)
  //Navigator.pushNamedAndRemoveUntil(context,newRouteName,(Route<dynamic>route)=>false);  //ข้ามไปกี่ตัวก็ได้ ใช้สำหรับ logout

  //App:page1 ->page2(*) ->page3 ->page4
  //Navigator.pushNameAndRemoveUntil(context,newRouteName,ModalRoute.withName(''));

  //App:page1(*) ->page2 ->page3 ->page4
  //Navigator.popUntil(context,ModalRoute.withName(''))   // มีข้อมูลกรอกเยอะ ต้องการยกเลิก

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: _route,
      title: "Navvigator",
      home: Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigator"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Navigator.pushNamed(context, '/page2');
            Navigator.pushReplacementNamed(
                context, '/page2'); //ไม่สามารถกด backได้
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}

class User {
  String fname;

  User(this.fname); //constructor   รับส่งค่า
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main 2"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pushNamed(context, '/page3');
            var user = User("Napaphorn");
            var tel = "1150";
            var result = Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Page3(user: user, text: tel),
              ),
            ); //push จากหน้า 2 ->3 มีรับส่งค่า
            print(result);
          },
          child: Text("Back"),
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  String text;
  User user;

  Page3({required this.user, required this.text});

  @override
  Widget build(BuildContext context) {
    print(user.fname);

    return Scaffold(
      appBar: AppBar(
        title: Text("Main 3"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Navigator.pushNamed(context, '/page4');
            Navigator.pop(context,"Call Back");
          },
          child: Text("Back"),
        ),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main 4"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Navigator.pushNamedAndRemoveUntil(context, '/page1', (Route<dynamic>route)=>false);
            //Navigator.pushNamedAndRemoveUntil(context, '/page4', ModalRoute.withName('/page1'));
            Navigator.popUntil(context,
                ModalRoute.withName('/page2')); //ใช้กรณีมี form กรอกข้อมูลเยอะๆ
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
