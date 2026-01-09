import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  void onModelReady(SettingsViewModel viewModel) {
    viewModel.init();
    super.onModelReady(viewModel);
  }


  @override
  Widget builder(BuildContext context, SettingsViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    _buildSettingsItem(Icons.edit_outlined, "Change Username", viewModel.onChangeUsername),
                    _buildSettingsItem(Icons.language, "Language Selection", viewModel.onLanguageSelect, trailingText: "English"),
                    _buildSettingsItem(Icons.send_outlined, "Feedback", () {}),
                    _buildSettingsItem(Icons.help_outline, "FAQ", () {}),
                    _buildSettingsItem(Icons.star_outline, "Rate Us", () {}),
                    _buildSettingsItem(Icons.share_outlined, "Share with Friends", () {}),
                    _buildSettingsItem(Icons.description_outlined, "Terms of Use", () {}),
                    _buildSettingsItem(Icons.privacy_tip_outlined, "Privacy Policy", () {}),
                    _buildSettingsItem(Icons.restore, "Restore Purchase", () {}),
                    
                    const SizedBox(height: 12),
                    _buildUserIdCard(context, viewModel.userId),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, VoidCallback onTap, {String? trailingText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black87, size: 22),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
              if (trailingText != null)
                Text(trailingText, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserIdCard(BuildContext context, String id) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline, color: Colors.grey, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "User ID",
                  style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  id,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, size: 18, color: Colors.grey),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: id)).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User ID copied to clipboard!")),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  
@override
SettingsViewModel viewModelBuilder(BuildContext context) {
  final vm = SettingsViewModel();
  // View oluşturulurken direkt başlatıyoruz
  Timer.run(() => vm.init()); 
  return vm;
}}