import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'loading_page.dart';

class RefreshLayout extends StatefulWidget {
  final Widget child;
  final Function onRefresh;
  final Function loadMore;
  final bool isEnableLoadMore;
  final bool firstRefresh;
  final Widget firstRefreshWidget;
  final GlobalKey<EasyRefreshState> easyRefreshKey;
  final GlobalKey<RefreshHeaderState> headerKey;
  final GlobalKey<RefreshFooterState> footerKey;

  const RefreshLayout(
      {Key key,
      @required this.child,
      this.onRefresh,
      this.easyRefreshKey,
      this.headerKey,
      this.footerKey,
      this.loadMore,
      this.isEnableLoadMore = true,
      this.firstRefresh = true,
      this.firstRefreshWidget})
      : assert(child != null),super(key: key);

  @override
  State<StatefulWidget> createState() => _RefreshLayoutState();
}

class _RefreshLayoutState extends State<RefreshLayout> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      key: widget.easyRefreshKey,
      autoControl: false,
      autoLoad: true,
      behavior: ScrollOverBehavior(),
      refreshHeader: ClassicsHeader(
        key: widget.headerKey,
        refreshText: "下拉刷新",
        refreshReadyText: "释放刷新",
        refreshingText: "正在刷新...",
        refreshedText: "刷新结束",
        moreInfo: "更新于",
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        moreInfoColor: Colors.black54,
        showMore: true,
      ),
      refreshFooter: ClassicsFooter(
        key: widget.footerKey,
        loadText: "上拉加载",
        loadReadyText: "释放加载",
        loadingText: "正在加载",
        loadedText: "加载结束",
        noMoreText: "没有更多数据",
        moreInfo: "更新于",
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        moreInfoColor: Colors.black54,
        showMore: true,
      ),
      child: widget.child,
      firstRefresh: widget.firstRefresh,
      firstRefreshWidget: widget.firstRefresh ? widget.firstRefreshWidget ?? LoadingPage() : null,
      onRefresh: widget.onRefresh,
      loadMore: widget.isEnableLoadMore ? widget.loadMore : null,
    );
  }
}
