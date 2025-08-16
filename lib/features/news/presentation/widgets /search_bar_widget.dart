import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/config/theme/app_colors.dart';
import 'package:news_app/core/config/theme/assets.dart';

class SearchBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final Function(String) onSearch;

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool _isSearching = false;
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => _isSearching = false);
      }
    });
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  void _cancelSearch() {
    setState(() {
      _isSearching = false;
    });
    _searchController.clear();
    widget.onSearch('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
      child: _isSearching
          ? Row(
        key: const ValueKey('searchField'),
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 28),
            onPressed: _cancelSearch,
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Поиск новостей...',
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close, size: 28, color: AppColors.black),
                  onPressed: () {
                    if (_searchController.text.isEmpty) {
                      _cancelSearch();
                    } else {
                      _searchController.clear();
                      widget.onSearch('');
                    }
                  },
                ),
              ),
              onChanged: widget.onSearch,
            ),
          ),
          const SizedBox(width: 12),
        ],
      )
          : Row(
        key: const ValueKey('searchButton'),
        children: [
          const SizedBox(width: 10),
          IconButton(
            onPressed: _startSearch,
            icon: SvgPicture.asset(
              AppAssets.search,
              width: 30,
              height: 30,
              colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}