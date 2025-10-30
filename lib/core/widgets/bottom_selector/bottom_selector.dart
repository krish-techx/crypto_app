import 'package:crypto_app/core/constants/app_color.dart';
import 'package:crypto_app/core/constants/app_spacing.dart';
import 'package:crypto_app/core/constants/assets.dart';
import 'package:crypto_app/core/enums/select_item.dart';
import 'package:crypto_app/core/widgets/custom_painters/bottom_cut_clipper.dart';
import 'package:crypto_app/core/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomSelector extends StatefulWidget {
  final String? label;
  final dynamic selectId;
  final String? sheetTitle;
  final List<SelectItem> children;
  final Function(dynamic id) onChange;

  const BottomSelector({
    super.key,
    this.label,
    this.selectId,
    this.sheetTitle,
    required this.children,
    required this.onChange,
  });

  @override
  State<BottomSelector> createState() => _BottomSelectorState();
}

class _BottomSelectorState extends State<BottomSelector> {
  SelectItem? _selectedItem;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _checkForInitialization(),
    );
  }

  Future<void> _checkForInitialization() async {
    for (int i = 0; i < widget.children.length; i++) {
      if (widget.children[i].id == widget.selectId) {
        _selectedItem = widget.children[i];
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomCutClipper(),
      child: Material(
        color: AppColors.surface,
        child: InkWell(
          onTap: () => _openBottomSheet(),
          splashColor: AppColors.white.withValues(alpha: 0.2),
          highlightColor: AppColors.white.withValues(alpha: 0.1),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: (AppSpacing.small + 2).w,
              vertical: AppSpacing.small.h,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.label != null) ...[
                        NText(
                          text: widget.label!,
                          color: AppColors.white.withValues(alpha: 0.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                        AppSpacing.h4,
                      ],
                      Row(
                        children: [
                          if (_selectedItem?.icon != null) ...[
                            Image.network(
                              _selectedItem!.icon!,
                              height: 24.w,
                              width: 24.w,
                            ),
                            AppSpacing.w4,
                          ],
                          NText(
                            text: _selectedItem?.itemName ?? '',
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  height: 16.w,
                  width: 16.w,
                  Assets.iconDropdown,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                AppSpacing.w8,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openBottomSheet() async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radius20.r),
        ),
      ),
      builder: (context) {
        return SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              if (widget.sheetTitle != null)
                NText(
                  text: widget.sheetTitle!,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  fontSize: 16,
                ),
              AppSpacing.h16,

              // List
              Flexible(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.small.w,
                    vertical: AppSpacing.small.h,
                  ),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: AppSpacing.small.w,
                    mainAxisSpacing: AppSpacing.small.h,
                    childAspectRatio: 1.8,
                  ),
                  itemCount: widget.children.length,
                  itemBuilder: (BuildContext context, int index) {
                    final isSelected =
                        widget.selectId == widget.children[index].id;

                    return InkWell(
                      borderRadius: BorderRadius.circular(AppSpacing.radius8.r),
                      onTap: () => _onSelectItem(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.1)
                              : AppColors.surface.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radius8.r,
                          ),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.transparent,
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.small + 2,
                          horizontal: AppSpacing.small,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.children[index].icon != null) ...[
                              Image.network(
                                widget.children[index].icon!,
                                height: 24.w,
                                width: 24.w,
                              ),
                              AppSpacing.w8,
                            ],

                            Expanded(
                              child: NText(
                                text: widget.children[index].itemName.trim(),
                                textAlign: TextAlign.start,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.white,
                                fontWeight: isSelected
                                    ? FontWeight.w900
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              AppSpacing.h16,
            ],
          ),
        );
      },
    );
  }

  void _onSelectItem(int index) {
    final selectedItem = widget.children[index];
    widget.onChange(selectedItem.id);
    _selectedItem = selectedItem;
    Navigator.pop(context);
  }
}
