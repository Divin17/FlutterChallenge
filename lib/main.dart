import 'package:flutter/material.dart';
import 'package:native_video_view/native_video_view.dart';
import 'package:request_permission/request_permission.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RequestPermission requestPermission = RequestPermission.instace;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Video Player Example"),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: _buildVideoPlayerWidget(),
            ),
            ElevatedButton(
              child: const Text("request internet permission"),
              onPressed: () {
                // 27 is the requestCode
                requestPermission.requestAndroidPermission("android.permission.INTERNET", 27);
              },
            ),
          ],
        ));
  }

  Widget _buildVideoPlayerWidget() {
    return Container(
      alignment: Alignment.center,
      child: NativeVideoView(
        keepAspectRatio: true,
        showMediaController: true,
        enableVolumeControl: true,
        onCreated: (controller) {
          controller.setVideoSource(
            'https://www.youtube.com/watch?v=dYZGnPuWmfQ',
            sourceType: VideoSourceType.network,
            requestAudioFocus: true,
          );
        },
        onPrepared: (controller, info) {
          requestPermission.requestAndroidPermission("android.permission.INTERNET", 1);
          debugPrint('******************NativeVideoView: Video prepared***********');
          controller.play();
        },
        onError: (controller, what, extra, message) {
          debugPrint('!!!!!!!!!!!!!!!!NativeVideoView: Player Error ($what | $extra | $message)!!!!!!!!!!!!!!!!!!!');
        },
        onCompletion: (controller) {
          debugPrint('##################NativeVideoView: Video completed###########');
        },
      ),
    );
  }
}
