import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/print_invoice_controller.dart';

class PrintInvoiceView extends GetView<PrintInvoiceController> {
  const PrintInvoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print Invoice'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Printer Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingRow(
              'Size',
              Obx(() => DropdownButton<String>(
                    value: controller.printerSize.value,
                    items: const [
                      DropdownMenuItem(
                        value: 'EPSON TM-T82',
                        child: Text('EPSON TM-T82'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.setPrinterSize(value);
                      }
                    },
                  )),
            ),
            _buildSettingRow(
              'Destination',
              Obx(() => DropdownButton<String>(
                    value: controller.destination.value,
                    items: const [
                      DropdownMenuItem(
                        value: 'Local Printer',
                        child: Text('Local Printer'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.setDestination(value);
                      }
                    },
                  )),
            ),
            _buildSettingRow(
              'Pages',
              Obx(() => DropdownButton<String>(
                    value: controller.pages.value,
                    items: const [
                      DropdownMenuItem(
                        value: 'All',
                        child: Text('All'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.setPages(value);
                      }
                    },
                  )),
            ),
            _buildSettingRow(
              'Copies',
              Obx(() => DropdownButton<int>(
                    value: controller.copies.value,
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text('1'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('2'),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text('3'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.setCopies(value);
                      }
                    },
                  )),
            ),
            _buildSettingRow(
              'Layout',
              Obx(() => DropdownButton<String>(
                    value: controller.layout.value,
                    items: const [
                      DropdownMenuItem(
                        value: 'Portrait',
                        child: Text('Portrait'),
                      ),
                      DropdownMenuItem(
                        value: 'Landscape',
                        child: Text('Landscape'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.setLayout(value);
                      }
                    },
                  )),
            ),
            _buildSettingRow(
              'Color',
              Obx(() => DropdownButton<String>(
                    value: controller.color.value,
                    items: const [
                      DropdownMenuItem(
                        value: 'Color',
                        child: Text('Color'),
                      ),
                      DropdownMenuItem(
                        value: 'Black & White',
                        child: Text('Black & White'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.setColor(value);
                      }
                    },
                  )),
            ),
            const SizedBox(height: 24),
            const Text(
              'Preview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Invoice Preview for ${controller.partnerName.value}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: controller.printInvoice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text('Print'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(String label, Widget dropdown) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          SizedBox(
            width: 200,
            child: dropdown,
          ),
        ],
      ),
    );
  }
}
