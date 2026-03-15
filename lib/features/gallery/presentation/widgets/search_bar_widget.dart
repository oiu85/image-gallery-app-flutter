import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../gen/assets.gen.dart';

class GallerySearchBar extends StatefulWidget {
  const GallerySearchBar({super.key, required this.onSearch, required this.onClear});

  final ValueChanged<String> onSearch;
  final VoidCallback onClear;

  @override
  State<GallerySearchBar> createState() => _GallerySearchBarState();
}

class _GallerySearchBarState extends State<GallerySearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    if (value.trim().isEmpty) return;

    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(value);
    });
  }

  void _onSubmitted(String value) {
    _debounce?.cancel();
    if (value.trim().isNotEmpty) {
      widget.onSearch(value);
    }
  }

  void _clear() {
    _controller.clear();
    widget.onClear();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(16.r)),
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        onSubmitted: _onSubmitted,
        textInputAction: TextInputAction.search,
        style: textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: 'Search images...',
          hintStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 14.w, right: 8.w),
            child: SvgPicture.asset(
              Assets.images.icons.search.path,
              width: 20.r,
              height: 20.r,
              colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn),
            ),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 42.w),
          suffixIcon: ListenableBuilder(
            listenable: _controller,
            builder: (_, _) {
              if (_controller.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: SvgPicture.asset(
                  Assets.images.icons.closeSquare.path,
                  width: 20.r,
                  height: 20.r,
                  colorFilter: ColorFilter.mode(colorScheme.outline, BlendMode.srcIn),
                ),
                onPressed: _clear,
              );
            },
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
