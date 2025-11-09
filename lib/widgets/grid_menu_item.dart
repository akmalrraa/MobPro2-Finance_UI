import 'package:flutter/material.dart';

class GridMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const GridMenuItem({
    super.key, 
    required this.icon, 
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8), // DIPERBESAR
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Container yang DIPERBESAR
            Container(
              width: 48, // DIPERBESAR
              height: 48, // DIPERBESAR
              decoration: BoxDecoration(
                color: isActive ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(12), // DIPERBESAR
                boxShadow: [
                  if (!isActive)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: isActive ? Colors.black : Colors.grey.shade300,
                  width: isActive ? 2 : 1, // DIPERBESAR
                ),
              ),
              child: Icon(
                icon, 
                size: 20, // DIPERBESAR
                color: isActive ? Colors.white : Colors.black87,
              ),
            ),
            
            const SizedBox(height: 6), // DIPERBESAR
            
            // Label dengan indikator aktif
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11, // DIPERBESAR
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                    color: isActive ? Colors.black : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2), // DIPERBESAR
                // Garis indikator aktif
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isActive ? 16 : 0, // DIPERBESAR
                  height: 1, // DIPERBESAR
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}