import 'package:flutter/material.dart';
import 'dart:math' as math;
@deprecated
class WillsRefreshIndicator extends StatefulWidget {

  final headerBuilder;

  final footerBuilder;

  final onRefresh;

  final onLoadMore;

  final IndexedWidgetBuilder itemBuilder;

  final int itemCount;

  //final double maxExpandExtent;

  final double holdExtent;

  WillsRefreshIndicator({
    Key key,
    this.headerBuilder,
    this.footerBuilder,
    this.itemBuilder,
    this.itemCount,
    this.holdExtent: 60.0,
    this.onLoadMore,
    this.onRefresh
  }): super(key: key);

  @override
  State createState() {
    return new WillsRefreshIndicatorState();
  }

}

enum WillsRefreshIndicatorStatus { PULL_DOWN, PULL_UP, HOLD_UP, HOLD_DOWN, IDLE }

enum WillsRefreshIndicatorProgressStatus {UNDO, PENDING, SUCCESS, FAIL}

enum WillsRefreshIndicatorDirection { START, END }


class WillsRefreshIndicatorState extends State<WillsRefreshIndicator> with TickerProviderStateMixin {

  double startDisplacement = 0.0;

  double endDisplacement = 0.0;

  WillsRefreshIndicatorStatus status = WillsRefreshIndicatorStatus.IDLE;

  WillsRefreshIndicatorDirection direction = WillsRefreshIndicatorDirection.START;

  WillsRefreshIndicatorProgressStatus progress = WillsRefreshIndicatorProgressStatus.UNDO;

  AnimationController startController;

  AnimationController endController;

  Animation<double> startOffsetFactor;

  Animation<double> endOffsetFactor;

  @override
  void initState() {
    super.initState();
    startController = new AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    endController = new AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    startOffsetFactor = new Tween<double>(
      begin: 0.0,
      end: widget.holdExtent * 2
    ).animate(new CurvedAnimation(parent: startController, curve: Curves.easeOut));

    endOffsetFactor = new Tween<double>(
      begin: 0.0,
      end: widget.holdExtent * 2
    ).animate(endController);

    startController.addListener(() {
      this.setState(() {});
    });

    endController.addListener(() {
      this.setState(() {});
    });

  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if(notification is ScrollStartNotification) {
      if(status == WillsRefreshIndicatorStatus.IDLE && notification.metrics.atEdge) {
        if(notification.metrics.pixels == notification.metrics.minScrollExtent) {
          status = WillsRefreshIndicatorStatus.PULL_DOWN;
        } else if(notification.metrics.pixels == notification.metrics.maxScrollExtent) {
          status = WillsRefreshIndicatorStatus.PULL_UP;
        }
      }
    } else if(notification is ScrollUpdateNotification) {
      if(status == WillsRefreshIndicatorStatus.PULL_UP) {

      } else if (status == WillsRefreshIndicatorStatus.PULL_DOWN) {
        //print(notification.scrollDelta);
        //print('$startDisplacement : ${notification.metrics.pixels} : ${notification.scrollDelta}');
        startDisplacement -= notification.scrollDelta;

      }
    } else if(notification is OverscrollNotification) {
      if(status == WillsRefreshIndicatorStatus.PULL_DOWN && notification.overscroll < 0) {
        //startDisplacement -= notification.overscroll;
        startDisplacement = math.min(widget.holdExtent * 2, startDisplacement - notification.overscroll);
        direction = WillsRefreshIndicatorDirection.START;
      } else if(status == WillsRefreshIndicatorStatus.PULL_UP && notification.overscroll > 0) {
        direction = WillsRefreshIndicatorDirection.END;
        endDisplacement = math.min(widget.holdExtent * 2, endDisplacement + notification.overscroll);
      }
    } else if(notification is ScrollEndNotification) {
      if(status == WillsRefreshIndicatorStatus.PULL_DOWN || status == WillsRefreshIndicatorStatus.PULL_UP) {
        if(startDisplacement >= widget.holdExtent) {
          progress = WillsRefreshIndicatorProgressStatus.PENDING;
          widget.onRefresh().then((_) {
            startDisplacement = 0.0;
            //status = WillsRefreshIndicatorStatus.IDLE;
            progress = WillsRefreshIndicatorProgressStatus.SUCCESS;
            _end();
          }).catchError((err) {
            startDisplacement = 0.0;
            //status = WillsRefreshIndicatorStatus.IDLE;
            progress = WillsRefreshIndicatorProgressStatus.FAIL;
            _end();
          });
          startDisplacement = widget.holdExtent;
          endDisplacement = 0.0;
          status = WillsRefreshIndicatorStatus.HOLD_UP;
        } else if(endDisplacement >= widget.holdExtent) {
          widget.onLoadMore().then((_) {
            endDisplacement = 0.0;
            //status = WillsRefreshIndicatorStatus.IDLE;
            progress = WillsRefreshIndicatorProgressStatus.SUCCESS;
            _end();
          }).catchError((err) {
            endDisplacement = 0.0;
            //status = WillsRefreshIndicatorStatus.IDLE;
            progress = WillsRefreshIndicatorProgressStatus.FAIL;
            _end();
          });
          endDisplacement = widget.holdExtent;
          startDisplacement = 0.0;
          status = WillsRefreshIndicatorStatus.HOLD_DOWN;
        } else {
          status = WillsRefreshIndicatorStatus.IDLE;
        }
        _end();
      }
    }

    if(status != WillsRefreshIndicatorStatus.IDLE) {
      _updateInternalStatus();
    }
    return true;
  }

  _end() {
    if(status == WillsRefreshIndicatorStatus.PULL_DOWN || status == WillsRefreshIndicatorStatus.HOLD_UP) {
      startController
        ..animateTo(startDisplacement).then((_) {
          if (progress == WillsRefreshIndicatorProgressStatus.SUCCESS
              || progress == WillsRefreshIndicatorProgressStatus.FAIL) {
            progress = WillsRefreshIndicatorProgressStatus.UNDO;
            status = WillsRefreshIndicatorStatus.IDLE;
          }
        });
    }
    if(status == WillsRefreshIndicatorStatus.PULL_UP || status == WillsRefreshIndicatorStatus.HOLD_DOWN) {
      endController
        ..animateTo(endDisplacement).then((_) {
          if (progress == WillsRefreshIndicatorProgressStatus.SUCCESS
              || progress == WillsRefreshIndicatorProgressStatus.FAIL) {
            progress = WillsRefreshIndicatorProgressStatus.UNDO;
            status = WillsRefreshIndicatorStatus.IDLE;
          }
        });
    }
  }

  _updateInternalStatus() {
    switch(direction) {
      case WillsRefreshIndicatorDirection.START:
        startController.value = startDisplacement / (widget.holdExtent * 2);
        break;
      case WillsRefreshIndicatorDirection.END:
        endController.value = endDisplacement / (widget.holdExtent * 2);
        break;
    }
  }

  bool _handleGlowNotification(OverscrollIndicatorNotification notification) {
    notification.disallowGlow();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Widget child = new NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: new NotificationListener<OverscrollIndicatorNotification>(
        onNotification: _handleGlowNotification,
        child: new Scrollbar(
          child: new CustomScrollView(
            physics: new ClampingScrollPhysics(),
            slivers: <Widget>[
              new SliverToBoxAdapter(
                child: new Container(
                  height: startOffsetFactor.value,
                  decoration: new BoxDecoration(color: Colors.red),
                  child: new Builder(
                    builder: (context) {
                      Widget child = widget.headerBuilder(
                        context,
                        startOffsetFactor.value / widget.holdExtent,
                        progress
                      );
                      return child;
                    },
                  ),
                ),
              ),
              new SliverList(
                delegate: new SliverChildBuilderDelegate(
                  widget.itemBuilder,
                  childCount: widget.itemCount
                ),
              ),
              new SliverToBoxAdapter(
                child: new Container(
                  constraints: new BoxConstraints(minHeight: endOffsetFactor.value),
                  decoration: new BoxDecoration(color: Colors.blue),
                  child: new Builder(
                    builder: (context) {
                      Widget child = widget.footerBuilder(
                        context,
                        startOffsetFactor.value / widget.holdExtent,
                        progress
                      );
                      return child;
                    },
                  ),
                ),
              ),
            ],
          )
        )
      ),
    );
    return child;
  }

}