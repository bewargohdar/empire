import 'package:flutter/material.dart';

class StretchableAppBar extends StatefulWidget {
  const StretchableAppBar(
      {Key? key,
      this.background,
      this.actions,
      this.leading,
      this.stretchModes,
      this.title,
      this.bottom,
      this.expandedHeight})
      : super(key: key);
  final Widget? background;
  final List<Widget>? actions;
  final Widget? leading;
  final String? title;
  final double? expandedHeight;
  final List<StretchMode>? stretchModes;
  final PreferredSizeWidget? bottom;
  @override
  State<StretchableAppBar> createState() => _StretchableAppBarState();
}

class _StretchableAppBarState extends State<StretchableAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      collapsedHeight: 60,
      elevation: 0,
      pinned: true,
      toolbarHeight: kToolbarHeight,
      centerTitle: false,
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: widget.expandedHeight,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: FlexibleSpaceBar(
            expandedTitleScale: 1.3,
            centerTitle: false,
            collapseMode: CollapseMode.parallax,
            stretchModes: widget.stretchModes ??
                const [
                  StretchMode.zoomBackground,
                ],
            background: Stack(
              fit: StackFit.expand,
              children: [
                widget.background ?? const SizedBox(),
              ],
            )),
      ),
      titleSpacing: 33,
      leadingWidth: 80,
      leading: widget.leading ??
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 27,
            ),
          ),
      automaticallyImplyLeading: false,
      actions: widget.actions,
      bottom: widget.bottom,
    );
  }
}
