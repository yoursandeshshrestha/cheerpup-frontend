// File: lib/pages/widgets/medications_page_tile.dart

import 'package:flutter/material.dart';

class MedicationsPageTile extends StatefulWidget {
  final List<String> availableMedicines;
  final List<String> selectedMedicines;
  final Function(String) onMedicineAdded;
  final Function(String) onMedicineRemoved;
  final VoidCallback onClearMedicines;
  final Function(String) onCustomMedicineAdded;
  final VoidCallback onSkip;

  const MedicationsPageTile({
    super.key,
    required this.availableMedicines,
    required this.selectedMedicines,
    required this.onMedicineAdded,
    required this.onMedicineRemoved,
    required this.onClearMedicines,
    required this.onCustomMedicineAdded,
    required this.onSkip,
  });

  @override
  State<MedicationsPageTile> createState() => _MedicationsPageTileState();
}

class _MedicationsPageTileState extends State<MedicationsPageTile> {
  final TextEditingController _customMedicineController = TextEditingController();
  String _searchQuery = '';
  List<String> _filteredMedicines = [];
  String _selectedLetter = 'A';

  @override
  void initState() {
    super.initState();
    _updateFilteredMedicines();
  }

  @override
  void dispose() {
    _customMedicineController.dispose();
    super.dispose();
  }

  void _updateFilteredMedicines() {
    if (_searchQuery.isEmpty) {
      // If no search query, filter by selected letter
      _filteredMedicines = widget.availableMedicines
          .where((medicine) => medicine.toUpperCase().startsWith(_selectedLetter))
          .toList();
    } else {
      // If search query exists, filter by that
      _filteredMedicines = widget.availableMedicines
          .where((medicine) => medicine.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  void _selectLetter(String letter) {
    setState(() {
      _selectedLetter = letter;
      _searchQuery = '';
      _updateFilteredMedicines();
    });
  }

  void _search(String query) {
    setState(() {
      _searchQuery = query;
      _updateFilteredMedicines();
    });
  }

  void _addCustomMedicine() {
    final medicine = _customMedicineController.text.trim();
    if (medicine.isNotEmpty) {
      widget.onCustomMedicineAdded(medicine);
      _customMedicineController.clear();
      // Clear focus
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Please specify your medications!",
            style: TextStyle(
              color: Colors.brown[900],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          // No medications button
          Center(
            child: InkWell(
              onTap: () {
                widget.onClearMedicines();
                widget.onSkip();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'No medications',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.close, color: Colors.grey[700], size: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Search bar
          TextField(
            onChanged: _search,
            decoration: InputDecoration(
              hintText: 'Search medications...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Letter filter
          SizedBox(
            height: 32,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final letter in ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'])
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: GestureDetector(
                      onTap: () => _selectLetter(letter),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: letter == _selectedLetter ? Colors.orange[300] : Colors.grey[200],
                        child: Text(
                          letter,
                          style: TextStyle(
                            color: letter == _selectedLetter ? Colors.white : Colors.grey[700],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Custom medicine input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _customMedicineController,
                  decoration: InputDecoration(
                    hintText: 'Add custom medication...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  ),
                  onSubmitted: (_) => _addCustomMedicine(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _addCustomMedicine,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Add', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // List of medications
          Expanded(
            child: _filteredMedicines.isEmpty
                ? Center(
                    child: Text(
                      'No medications found',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredMedicines.length,
                    itemBuilder: (context, index) {
                      final medicine = _filteredMedicines[index];
                      final isSelected = widget.selectedMedicines.contains(medicine);
                      
                      return _buildMedicineItem(medicine, isSelected);
                    },
                  ),
          ),
          
          // Selected medications
          if (widget.selectedMedicines.isNotEmpty)
            _buildSelectedMedicinesChips(),
          
          // Skip option instead of having it in the main page
          TextButton(
            onPressed: widget.onSkip,
            child: Center(
              child: Text(
                'Skip this step',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineItem(String medicine, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green[100] : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.green : Colors.grey[300]!,
        ),
      ),
      child: ListTile(
        dense: true, // Make list items more compact
        title: Text(
          medicine,
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Checkbox(
          value: isSelected,
          activeColor: Colors.green,
          onChanged: (value) {
            if (isSelected) {
              widget.onMedicineRemoved(medicine);
            } else {
              widget.onMedicineAdded(medicine);
            }
          },
        ),
        onTap: () {
          if (isSelected) {
            widget.onMedicineRemoved(medicine);
          } else {
            widget.onMedicineAdded(medicine);
          }
        },
      ),
    );
  }

  Widget _buildSelectedMedicinesChips() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Medications',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8, // Add vertical spacing between rows of chips
            children: widget.selectedMedicines.map((medicine) {
              return Chip(
                label: Text(
                  medicine,
                  style: const TextStyle(fontSize: 12),
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () {
                  widget.onMedicineRemoved(medicine);
                },
                backgroundColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Make chips more compact
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}