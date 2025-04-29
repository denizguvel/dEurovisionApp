import 'package:eurovision_app/app/features/presentation/home_detail/view/home_detail_imports.dart';

/// A counter box widget with an icon and text.
/// Commonly used to display year or selection count.
class CounterBox extends StatelessWidget {
  final IconData icon;
  final String text;

  const CounterBox({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.white, size: 18),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}