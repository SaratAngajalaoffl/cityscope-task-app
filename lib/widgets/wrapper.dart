import 'package:cityscope/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:cityscope/screens/authenticate/authenticate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cityscope/screens/home/home.dart';

const _storage = FlutterSecureStorage();

class WrapperWidget extends StatefulWidget {
  const WrapperWidget({Key? key}) : super(key: key);

  @override
  State<WrapperWidget> createState() => _WrapperWidgetState();
}

class _WrapperWidgetState extends State<WrapperWidget> {
  String? _token;
  bool _loading = true;

  @override
  void initState() {
    getAccessToken();
    super.initState();
  }

  Future<void> getAccessToken() async {
    String? accessToken = await _storage.read(key: "accessToken");

    setState(() {
      _token = accessToken;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const LoadingIndicator();
    } else if (_token == null) {
      return AuthenticationScreen(getAccessToken: getAccessToken);
    } else {
      return HomeScreen(getAccessToken: getAccessToken);
    }
  }
}
