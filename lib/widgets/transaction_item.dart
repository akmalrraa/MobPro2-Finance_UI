import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Logo/Icon sesuai dengan merchant
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _getLogoBackgroundColor(transaction.title),
              borderRadius: BorderRadius.circular(8),
              image: _getTransactionLogo(transaction.title),
            ),
          ),
          
          const SizedBox(width: 10),
          
          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.category,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          
          // Amount and Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction.amount,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                transaction.date,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Method untuk mendapatkan logo berdasarkan merchant
  DecorationImage? _getTransactionLogo(String title) {
    switch (title.toLowerCase()) {
      case 'netflix':
        return const DecorationImage(
          image: AssetImage('assets/images/netflix_logo.jpeg'),
          fit: BoxFit.contain,
        );
      case 'starbucks':
        return const DecorationImage(
          image: AssetImage('assets/images/starbucks_logo.jpeg'),
          fit: BoxFit.contain,
        );
      case 'amazon':
        return const DecorationImage(
          image: AssetImage('assets/images/amazon_logo.jpeg'),
          fit: BoxFit.contain,
        );
      case 'spotify':
        return const DecorationImage(
          image: AssetImage('assets/images/spotify_logo.jpeg'),
          fit: BoxFit.contain,
        );
      default:
        return null;
    }
  }

  // Method untuk mendapatkan warna background logo sesuai brand
  Color _getLogoBackgroundColor(String title) {
    // Jika ada asset image, gunakan background transparan
    if (_getTransactionLogo(title) != null) {
      return Colors.transparent;
    }
    
    // Fallback color untuk merchant yang tidak memiliki asset
    final colors = [
      const Color(0xFF3498DB),
      const Color(0xFF2ECC71),
      const Color(0xFFE74C3C),
      const Color(0xFF9B59B6),
    ];
    return colors[title.hashCode % colors.length];
  }
}