
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  // loading完成呈现的内容
  final Widget child;
  // 是否正在加载
  final bool isLoading;
  // 是否全部覆盖
  final bool cover;

  const LoadingContainer({
    Key? key,
    required this.child,
    required this.isLoading,
    this.cover = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover ? (!isLoading ? child : _loadingView) :
          Stack(
            children: [child,if (isLoading) _loadingView],
          );
  }

  Widget get _loadingView{
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}