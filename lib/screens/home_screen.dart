import 'package:flutter/material.dart';
import '../widgets/atm_card.dart';
import '../widgets/transaction_item.dart';
import '../models/transaction.dart';
import '../widgets/grid_menu_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  int _selectedMenuIndex = 0;

  final transactions = [
    TransactionModel('Netflix', '\$15.99', 'Entertainment', 'Today 19:30'),
    TransactionModel('Starbucks', '\$5.75', 'Food & Drink', 'Today 16:15'),
    TransactionModel('Amazon', '\$42.50', 'Shopping', 'Yesterday 14:20'),
    TransactionModel('Spotify', '\$9.99', 'Entertainment', 'Mar 12, 2024'),
  ];

  final cards = [
    {
      'number': '1234 9048 9480 9234', 
      'balance': '\$200', 
      'cvv': '124', 
      'expiry': '12/25',
      'chipImage': 'assets/images/silverchip.png',
    },
    {
      'number': '5678 1234 5678 9012', 
      'balance': '\$350', 
      'cvv': '567', 
      'expiry': '03/26',
      'chipImage': 'assets/images/silverchip.png',
    },
    {
      'number': '9012 3456 7890 1234', 
      'balance': '\$150', 
      'cvv': '890', 
      'expiry': '09/27',
      'chipImage': 'assets/images/silverchip.png',
    },
  ];

  final menuItems = [
    {'icon': Icons.compare_arrows, 'label': 'Transfer'},
    {'icon': Icons.receipt, 'label': 'Pay Bills'},
    {'icon': Icons.savings, 'label': 'Savings'},
    {'icon': Icons.trending_up, 'label': 'Investments'},
    {'icon': Icons.history, 'label': 'History'},
  ];

  // Data untuk Budget Progress
  final budgetCategories = [
    {'category': 'Food & Drink', 'spent': 320, 'total': 500, 'color': const Color.fromARGB(255, 221, 255, 0)},
    {'category': 'Shopping', 'spent': 180, 'total': 300, 'color': const Color.fromARGB(255, 132, 2, 253)},
    {'category': 'Transport', 'spent': 120, 'total': 200, 'color': Colors.blue},
    {'category': 'Entertainment', 'spent': 80, 'total': 150, 'color': Colors.green},
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onMenuTap(int index) {
    setState(() {
      _selectedMenuIndex = index;
    });
  }

  double _calculatePercentage(int spent, int total) {
    return spent / total;
  }

  Color _getProgressColor(double percentage) {
    if (percentage >= 0.8) return Colors.red;
    if (percentage >= 0.6) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final totalSpent = budgetCategories.fold(0, (sum, category) => sum + (category['spent'] as int));
    final totalBudget = 1150;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ===== Bagian Atas (Hitam) =====
            Expanded(
              flex: 6, // DIPERBESAR untuk memberi ruang
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello,',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFAAAAAA),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Akmal Rabbih Aizar',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFF333333),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.notifications,
                              color: Color(0xFFAAAAAA),
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // ATM Cards Carousel
                      SizedBox(
                        height: 170,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: AtmCard(
                                cardNumber: cards[index]['number']!,
                                balance: cards[index]['balance']!,
                                cvv: cards[index]['cvv']!,
                                expire: cards[index]['expiry']!,
                                chipImage: cards[index]['chipImage']!,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Page Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(cards.length, (index) {
                          return Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index 
                                  ? Colors.white 
                                  : Colors.white.withOpacity(0.3),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),

                      // Grid Menu - DIPERBESAR
                      Container(
                        height: 100, // DIPERBESAR dari 55
                        margin: const EdgeInsets.only(bottom: 20), // Spacing lebih besar
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: menuItems.asMap().entries.map((entry) {
                            final index = entry.key;
                            final menuItem = entry.value;
                            return Expanded(
                              child: GridMenuItem(
                                icon: menuItem['icon'] as IconData,
                                label: menuItem['label'] as String,
                                isActive: _selectedMenuIndex == index,
                                onTap: () => _onMenuTap(index),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // === Budget Progress - DIPINDAH KEBAWAH ===
                      const SizedBox(height: 8), // Spacing sebelum Budget Progress
                      const Text(
                        'Budget Progress',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Budget Progress Container
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            // Header dengan total budget
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Monthly Budget',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '\$$totalSpent / \$$totalBudget',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            
                            // Progress bar utama
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    width: double.infinity * (totalSpent / totalBudget),
                                    decoration: BoxDecoration(
                                      color: _getProgressColor(totalSpent / totalBudget),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            
                            // Budget categories
                            _buildBudgetCategories(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),

            // ===== Bagian Bawah (Putih dengan Curve) =====
            Expanded(
              flex: 4, // DIPERBESAR
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Transactions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              return TransactionItem(transaction: transactions[index]);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method untuk budget categories
  Widget _buildBudgetCategories() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildBudgetCategory(budgetCategories[0])),
            const SizedBox(width: 8),
            Expanded(child: _buildBudgetCategory(budgetCategories[1])),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildBudgetCategory(budgetCategories[2])),
            const SizedBox(width: 8),
            Expanded(child: _buildBudgetCategory(budgetCategories[3])),
          ],
        ),
      ],
    );
  }

  // Helper method untuk membangun budget category item
  Widget _buildBudgetCategory(Map<String, dynamic> category) {
    final spent = category['spent'] as int;
    final total = category['total'] as int;
    final percentage = _calculatePercentage(spent, total);
    final color = category['color'] as Color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category['category'] as String, // Tampilkan nama kategori lengkap
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '\$$spent',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 3,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(2),
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: double.infinity * percentage,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}