import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';
import 'package:learning/ui/common/common.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WistiaPlayer extends StatefulWidget {
  const WistiaPlayer({
    Key key,
    this.videoId,
  }) : super(key: key);

  final String videoId;

  @override
  _WistiaPlayerState createState() => _WistiaPlayerState();
}

class _WistiaPlayerState extends State<WistiaPlayer> {
  WebViewController webView;
  double progress = 0;
  LoadingStatus loadingStatus = LoadingStatus.loading;

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
    return LoadingView(
      status: loadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Hubo un problema cargando el video.',
        onRetry: () => webView?.reload(),
      ),
      successContent: _buildWebView(),
    );
  }

  Widget _buildWebView() {
    return Container(
      height: 300.0,
      child: WebView(
        initialUrl: 'https://fast.wistia.net/embed/iframe/${widget.videoId}',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          webView = controller;
          _changeLoadingStatus(LoadingStatus.success);
        },
      ),
    );
  }

  void _changeLoadingStatus(LoadingStatus status) {
    setState(() {
      loadingStatus = status;
    });
  }
}
