import 'package:flutter/material.dart';
import 'package:numera/config/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  final double expandedHeight = 110.0;

  const CustomAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      actions: actions,
      pinned: true,
      expandedHeight: expandedHeight,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final double top = constraints.maxHeight;
          final double statusBarHeight = MediaQuery.of(context).padding.top;

          final double collapsedHeight = kToolbarHeight + statusBarHeight;
          final double fullyExpandedHeight = expandedHeight + statusBarHeight;

          double progress = 0.0;
          if (fullyExpandedHeight > collapsedHeight) {
            progress =
                (fullyExpandedHeight - top) /
                (fullyExpandedHeight - collapsedHeight);
            progress = progress.clamp(0.0, 1.0);
          }

          final double currentLeftPadding = 20.0 + (56.0 * progress);
          final double currentBottomPadding = 0.0 + (26.0 * progress);
          final double currentBgOpacity = 0 + (0.08 * progress);

          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: AppColors.primaryDark.withOpacity(currentBgOpacity),
              ),
              FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(
                  left: currentLeftPadding,
                  bottom: currentBottomPadding,
                  right: 20.0,
                ),
                centerTitle: false,
                title: Expanded(
                  child: Text(
                    title,
                    style: AppFonts.appBarTitle.copyWith(fontSize: 20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                expandedTitleScale: 1.2,
              ),
            ],
          );
        },
      ),
    );
  }
}
