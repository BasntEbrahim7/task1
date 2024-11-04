import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../components/textField.dart';
import '../data/model.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  late SharedPreferences prefs;
  List<Branch> branches = [];
  int currentIndex = 0;

  TextEditingController customNoController = TextEditingController();
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController arabicDescriptionController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController englishDescriptionController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBranches();
  }

  void _loadBranches() async {
    prefs = await SharedPreferences.getInstance();
    List<String> branchStrings = prefs.getStringList('branches') ?? [];

    setState(() {
      branches = branchStrings.map((b) => Branch.fromJson(jsonDecode(b))).toList();
      if (branches.isNotEmpty) {
        currentIndex = 0;
        _loadBranchData(currentIndex);
      }
    });
  }

  void _loadBranchData(int index) {
    if (index >= 0 && index < branches.length) {
      final branch = branches[index];
      customNoController.text = branch.customNo ?? '';
      arabicNameController.text = branch.arabicName ?? '';
      arabicDescriptionController.text = branch.arabicDescription ?? '';
      englishNameController.text = branch.englishName ?? '';
      englishDescriptionController.text = branch.englishDescription ?? '';
      noteController.text = branch.note ?? '';
      addressController.text = branch.address ?? '';
    }
  }

  void _saveBranchesToPrefs() async {
    List<String> branchStrings = branches.map((b) => jsonEncode(b.toJson())).toList();
    await prefs.setStringList('branches', branchStrings);
  }

  void _addBranch() {
    // Start branch IDs from 1 instead of length
    final newBranch = Branch(branchId: branches.isEmpty ? 1 : branches.length + 1);
    setState(() {
      branches.add(newBranch);
      currentIndex = branches.length - 1;
      _loadBranchData(currentIndex);
    });
    _saveBranchesToPrefs();
  }

  void _saveBranch() {
    if (currentIndex >= 0 && currentIndex < branches.length) {
      final branch = branches[currentIndex];
      branch.customNo = customNoController.text;
      branch.arabicName = arabicNameController.text;
      branch.arabicDescription = arabicDescriptionController.text;
      branch.englishName = englishNameController.text;
      branch.englishDescription = englishDescriptionController.text;
      branch.note = noteController.text;
      branch.address = addressController.text;

      _saveBranchesToPrefs();
    }
  }

  void _navigateBranch(int newIndex) {
    if (newIndex >= 0 && newIndex < branches.length) {
      setState(() {
        currentIndex = newIndex;
        _loadBranchData(currentIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final branch = branches.isNotEmpty ? branches[currentIndex] : Branch(branchId: 0);
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth >= 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff025fae),
        title: Row(
          children: [
            const Text(
              "Branch / Store / Cashier",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Spacer(),
            IconButton(
              onPressed: _addBranch,
              icon: const Icon(Icons.add_circle, color: Colors.white, size: 24),
            ),
            IconButton(
              onPressed: _saveBranch,
              icon: const Icon(Icons.save_rounded, color: Colors.white, size: 24),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLargeScreen)
              Row(
                children: [
                  Expanded(
                    child: InputFieldWidget(
                      label: "Branch",
                      hintText: branch.branchId.toString(),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputFieldWidget(
                      label: "Custom No.",
                      controller: customNoController,
                    ),
                  ),
                ],
              )
            else
              Row(
                children: [
                  Column(
                    children: [
                      Text("Branch", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      Container(
                        width: 180,
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: branch.branchId.toString(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    children: [
                      Text("Custom No.", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      Container(
                        width: 130,
                        child: TextField(
                          controller: customNoController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 16),
            if (isLargeScreen)
              Row(
                children: [
                  Expanded(
                    child: InputFieldWidget(
                      label: "Arabic Name",
                      controller: arabicNameController,
                      textDirection: TextDirection.rtl,
                      KeyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputFieldWidget(
                      label: "Arabic Description",
                      controller: arabicDescriptionController,
                      textDirection: TextDirection.rtl,
                      KeyboardType: TextInputType.text,

                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  InputFieldWidget(
                    label: "Arabic Name",
                    controller: arabicNameController,
                    textDirection: TextDirection.rtl,
                    KeyboardType: TextInputType.text,

                  ),
                  const SizedBox(height: 16),
                  InputFieldWidget(
                    label: "Arabic Description",
                    controller: arabicDescriptionController,
                    textDirection: TextDirection.rtl,
                    KeyboardType: TextInputType.text,

                  ),
                ],
              ),
            const SizedBox(height: 16),
            if (isLargeScreen)
              Row(
                children: [
                  Expanded(
                    child: InputFieldWidget(
                      label: "English Name",
                      controller: englishNameController,
                      KeyboardType: TextInputType.text,

                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputFieldWidget(
                      label: "English Description",
                      controller: englishDescriptionController,
                      KeyboardType: TextInputType.text,

                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  InputFieldWidget(label: "English Name", controller: englishNameController),
                  const SizedBox(height: 16),
                  InputFieldWidget(label: "English Description", controller: englishDescriptionController),
                ],
              ),
            const SizedBox(height: 16),
            if (isLargeScreen)
              Row(
                children: [
                  Expanded(
                    child: InputFieldWidget(label: "Note", controller: noteController,  KeyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputFieldWidget(label: "Address", controller: addressController,  KeyboardType: TextInputType.text,
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  InputFieldWidget(label: "Note", controller: noteController, KeyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),
                  InputFieldWidget(label: "Address", controller: addressController,  KeyboardType: TextInputType.text,
                  ),
                ],
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.first_page, color: currentIndex > 0 ? Colors.blue : Colors.grey),
                  onPressed: currentIndex > 0 ? () => _navigateBranch(0) : null,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back, color: currentIndex > 0 ? Colors.blue : Colors.grey),
                  onPressed: currentIndex > 0 ? () => _navigateBranch(currentIndex - 1) : null,
                ),
                Text(
                  '${currentIndex + 1}/${branches.length}',
                  style: const TextStyle(fontSize: 18, color: Colors.blue),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: currentIndex < branches.length - 1 ? Colors.blue : Colors.grey),
                  onPressed: currentIndex < branches.length - 1 ? () => _navigateBranch(currentIndex + 1) : null,
                ),
                IconButton(
                  icon: Icon(Icons.last_page, color: currentIndex < branches.length - 1 ? Colors.blue : Colors.grey),
                  onPressed: currentIndex < branches.length - 1 ? () => _navigateBranch(branches.length - 1) : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
