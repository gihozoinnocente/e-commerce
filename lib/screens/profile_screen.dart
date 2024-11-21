import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement settings navigation
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings coming soon!'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Account',
              children: [
                _buildListTile(
                  icon: Icons.shopping_bag,
                  title: 'My Orders',
                  subtitle: 'Check your order status',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.favorite,
                  title: 'Wishlist',
                  subtitle: 'Your favorite items',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.location_on,
                  title: 'Shipping Address',
                  subtitle: 'Manage delivery addresses',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Settings',
              children: [
                _buildListTile(
                  icon: Icons.payment,
                  title: 'Payment Methods',
                  subtitle: 'Manage your payment options',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  subtitle: 'Manage notification preferences',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: 'Change app language',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Support',
              children: [
                _buildListTile(
                  icon: Icons.help,
                  title: 'Help Center',
                  subtitle: 'FAQ and support resources',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.policy,
                  title: 'Privacy Policy',
                  subtitle: 'Our privacy policy',
                  onTap: () {},
                ),
                _buildListTile(
                  icon: Icons.info,
                  title: 'About Us',
                  subtitle: 'Learn more about us',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement logout
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logout functionality coming soon!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('Logout'),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        onTap();
      },
    );
  }
}