import 'package:flutter/material.dart';

class AtmCard extends StatelessWidget {
  final String cardNumber;
  final String balance;
  final String cvv;
  final String expire;
  final String chipImage;

  const AtmCard({
    super.key,
    required this.cardNumber,
    required this.balance,
    required this.cvv,
    required this.expire,
    required this.chipImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2C2C2C), Color(0xFF1A1A1A)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            top: -15,
            right: -15,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Konten utama kartu
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hanya judul ATM CARD saja
                const Text(
                  'BLACK CARD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Chip Area dengan gambar silver chip
                Image.asset(
                  chipImage,
                  width: 30,
                  height: 22,
                  fit: BoxFit.contain,
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  cardNumber,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                  ),
                ),
                
                const Spacer(),
                
                // Bagian bawah dengan informasi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // CVV Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CVV',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          cvv,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    
                    // Balance Section
                    Column(
                      children: [
                        Text(
                          balance,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    
                    // Expiry Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EXPIRE',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          expire,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Contactless Icon
          const Positioned(
            top: 16,
            right: 16,
            child: Icon(
              Icons.contactless_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}