import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../config/theme/app_theme.dart';

class MathMethodCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String formulaMain;
  final String formulaSub;
  final VoidCallback onTap;

  const MathMethodCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.formulaMain,
    required this.formulaSub,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.fillPaleGray, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  bottom: -15,
                  child: Opacity(
                    opacity: 0.06,
                    child: Transform.rotate(
                      angle: -0.15,
                      child: Text(
                        formulaMain,
                        style: TextStyle(
                          fontSize: 65,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          letterSpacing: -2,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 15,
                  child: Opacity(
                    opacity: 0.05,
                    child: Text(
                      formulaSub,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(icon, color: AppColors.primary, size: 28),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: AppFonts.headline8.copyWith(
                                color: AppColors.primaryDark,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              description,
                              style: AppFonts.bodyText3.copyWith(
                                color: AppColors.textDarkGray,
                                height: 1.3,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 10),
                        child: HeroIcon(
                          HeroIcons.chevronRight,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
