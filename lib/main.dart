import 'package:flutter/material.dart';

void main() {
  runApp(PrimeCheckerApp());
}

class PrimeCheckerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prime Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrimeCheckerHomePage(),
    );
  }
}

class PrimeCheckerHomePage extends StatefulWidget {
  @override
  _PrimeCheckerHomePageState createState() => _PrimeCheckerHomePageState();
}

class _PrimeCheckerHomePageState extends State<PrimeCheckerHomePage> {
  TextEditingController _numberController = TextEditingController();
  String _result = '';
  String _timeTaken = '';

  bool isPrime(int n) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;

    for (int i = 5; i * i <= n; i += 6) {
      if (n % i == 0 || n % (i + 2) == 0) return false;
    }
    return true;
  }
  

  void checkPrime() {
    int num = int.tryParse(_numberController.text) ?? 0;

    if (num <= 0) {
      setState(() {
        _result = 'กรุณากรอกตัวเลขที่มากกว่า 0';
        _timeTaken = '';
      });
      return;
    }

    var startTime = DateTime.now().microsecondsSinceEpoch;
    bool result = isPrime(num);
    var endTime = DateTime.now().microsecondsSinceEpoch;

    setState(() {
      _result = result ? '$num เป็น Prime Number' : '$num ไม่เป็น Prime Number';
      _timeTaken = 'เวลาที่ใช้: ${(endTime - startTime) / 1000} milliseconds';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตรวจสอบ Prime Number'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'กรอกตัวเลข',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: checkPrime,
              child: Text('ตรวจสอบ'),
            ),
            SizedBox(height: 20.0),
            Text(
              _result,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              _timeTaken,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
