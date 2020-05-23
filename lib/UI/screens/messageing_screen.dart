import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customerapp/shared_data.dart';
import 'package:url_launcher/url_launcher.dart';

class MessagingScreen extends StatefulWidget {
  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen>
    with TickerProviderStateMixin {
  final List<Msg> _messages = <Msg>[];

  BuildContext ctx ;
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;
  @override
  Widget build(BuildContext ctx) {
    this.ctx = ctx ;
    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        child:  Image.asset('assets/images/icons/whatsapp.png'),
        onPressed: (){
          launch(sharedData.whatsAppURL);
        },
      ),*/
       body: getBody(),
    );
  }

   Widget getBody(){
    return Container(
      child: ListView(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height - 178,
          child: _messages.length > 0
              ? Container(
            child: new ListView.builder(
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
              reverse: true,
              padding: new EdgeInsets.all(10.0),
            ),
          )
              : NoMessage(),
        ),
        new Divider(height: 1.5),
        new Container(
          width: MediaQuery.of(context).size.width,
          child: _buildComposer(),
          decoration: new BoxDecoration(
              color: Theme.of(ctx).cardColor,
              boxShadow: [BoxShadow(blurRadius: 1.0, color: Colors.black12)]),
        ),
      ]),
    );
  }
  /// Component for typing text
  Widget _buildComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(onPressed: (){
                launch(sharedData.whatsAppURL);
              },
                icon: Image.asset("assets/images/icons/whatsapp.png",height: 26,width: 26,)),
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                          child: new Text("Submit"),
                          onPressed: _isWriting
                              ? () => _submitMsg(_textController.text)
                              : null)
                      : new IconButton(
                          icon: new Icon(Icons.message),
//                          onPressed: _isWriting
//                              ? () => _submitMsg(_textController.text)
//                              : null,
                        )),

              new Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 0.5,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: new TextField(
                    focusNode: FocusNode(),
//                    controller: _textController,
//                    onChanged: (String txt) {
////                      setState(() {
////                        _isWriting = txt.length > 0;
////                      });
//                    },
//                    onSubmitted: _submitMsg,
//                    decoration: new InputDecoration.collapsed(
//                        hintText: "اكتب نص الرسالة",
//                        hintStyle:
//                            TextStyle(fontSize: 16.0, color: Colors.black26)),
                  ),
                ),
              ),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border: new Border(top: new BorderSide(color: Colors.brown)))
              : null),
    );
  }

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    Msg msg = new Msg(
      txt: txt,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 800)),
    );
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
  }

  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    appbarBloc.setTitle("المراسلة");
  }
}

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});
  final String txt;
  final AnimationController animationController;
  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.fastOutSlowIn),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 18.0),
              child: new CircleAvatar(
                  backgroundColor: Colors.indigoAccent,
                  child: new Text("عميل بطريق ماركت")),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("عميل بطريق ماركت",
                      style: TextStyle(
                          fontFamily: "Gotik", fontWeight: FontWeight.w900)),
                  new Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: new Text(txt),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Opacity(
              opacity: 0.5,
              child: Icon(
                Icons.chat_bubble_outline,
                size: 100,
                color: sharedData.mainColor,
              )),
          Text(
            "لاتوجد رسائل",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.black12,
                fontSize: 17.0,
                fontFamily: "Popins"),
          )
        ],
      ),
    ));
  }
}
