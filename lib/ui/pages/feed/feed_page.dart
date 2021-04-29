import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../main/helpers/theme_colors.dart';
import '../../helpers/ui_errors.dart';
import '../components/await_connection.dart';
import 'components/highlight_box.dart';
import 'components/post_item.dart';
import 'components/reload_screen.dart';
import 'feed_presenter.dart';
import 'post_viewmodel.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _feedPresenter = Modular.get<FeedPresenter>();

  @override
  void initState() {
    super.initState();
    _feedPresenter.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mesa News'),
        brightness: Brightness.dark,
        leading: Container(),
        backgroundColor: ThemeColors.of(context).primary,
        actions: [
          IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                Modular.to.pushNamed('/filter');
              })
        ],
      ),
      body: StreamBuilder<List<PostViewModel>>(
          stream: _feedPresenter.outPostViewModelList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              UIError uiError = snapshot.error;
              return ReloadScreen(error: uiError.description, reload: _feedPresenter.loadData);
            }
            return snapshot.hasData && snapshot.data.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 30),
                    itemCount: snapshot.data.length + 1,
                    itemBuilder: (context, index) {
                      if (index < snapshot.data.length - 1) {
                        if (index == 0) return HeaderBox(listPostViewModel: _feedPresenter.highlightsPosts);
                        return PostItem(postViewModel: snapshot.data[index - 1]);
                      } else {
                        return FutureBuilder<bool>(
                            future: _feedPresenter.loadNextPageData(),
                            initialData: false,
                            builder: (context, snapshot) {
                              return snapshot.hasData && snapshot?.data == true
                                  ? Container()
                                  : FutureBuilder<bool>(
                                      future: Future.delayed(Duration(milliseconds: 800), () => true),
                                      initialData: false,
                                      builder: (context, loading) {
                                        return loading.data
                                            ? Container()
                                            : Center(
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  margin: const EdgeInsets.only(bottom: 100),
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                  ),
                                                ),
                                              );
                                      });
                            });
                      }
                    },
                  )
                : AwaitConnectionWidget(onTap: _feedPresenter.reloadData);
          }),
    );
  }
}
