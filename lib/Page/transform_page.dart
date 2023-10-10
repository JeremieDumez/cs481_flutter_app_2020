import 'package:flutter/material.dart';

class TransformPage extends StatefulWidget {
  @override
  _TransformPageState createState() => _TransformPageState();
}

class _TransformPageState extends State<TransformPage> {
  double _scale = 0.5;

  initState() {
    super.initState();
  }

  void scaleUp() {
    setState(() {
      _scale += 0.1;
    });
  }

  void scaleDown() {
    setState(() {
      if (_scale <= 0.2)
        _scale = 0.2;
      else
        _scale -= 0.1;
    });
  }

  popPage() {
    Navigator.of(context).pop(TransformPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_outlined,
            size: 30,
          ),
          onPressed: popPage,
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Transform.scale(
          scale: _scale,
          child: Image.asset('assets/no_image.png'),
        ),
        Row(
          children: [
            SizedBox(
              width: 250,
              child: MaterialButton(
                height: 60,
                onPressed: scaleDown,
                color: Colors.green,
                textColor: Colors.white,
                child: Icon(Icons.zoom_out, size: 40),
                shape: CircleBorder(),
              ),
            ),
            MaterialButton(
              height: 60,
              onPressed: scaleUp,
              color: Colors.green,
              textColor: Colors.white,
              child: Icon(
                Icons.zoom_in,
                size: 40,
              ),
              shape: CircleBorder(),
            ),
          ],
        ),
      ]),
    );
  }
}
