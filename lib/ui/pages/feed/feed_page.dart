import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mesa_news/main/helpers/theme_colors.dart';
import 'package:mesa_news/ui/pages/feed/components/highlight_box.dart';
import 'package:mesa_news/ui/pages/feed/components/post_item.dart';
import 'package:mesa_news/ui/pages/feed/components/reload_screen.dart';
import 'package:mesa_news/ui/pages/feed/feed_presenter.dart';
import 'package:mesa_news/ui/pages/feed/post_viewmodel.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mesa News'),
        brightness: Brightness.dark,
        backgroundColor: ThemeColors.of(context).primary,
        actions: [
          IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                // TODO: chamar tela de filtro
              })
        ],
      ),
      body: StreamBuilder<List<PostViewModel>>(
          stream: _feedPresenter.outPostViewModelList,
          builder: (context, snapshot) {
            if (snapshot.hasError) return ReloadScreen(error: snapshot.error, reload: _feedPresenter.loadData);
            return snapshot.hasData && snapshot.data.isNotEmpty
                ? ListView.builder(
                    itemCount: 3 + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) return HighlightBox(listPostViewModel: _feedPresenter.highlightsPosts);
                      return PostItem(postViewModel: snapshot.data[index - 1]);
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}
