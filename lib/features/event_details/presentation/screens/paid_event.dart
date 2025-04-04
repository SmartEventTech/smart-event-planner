import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:smart_event_planner/features/payment/screens/payment_options_screen.dart';

class PaidEvent extends StatefulWidget {
  const PaidEvent({super.key});

  @override
  _PaidEventState createState() => _PaidEventState();
}

class _PaidEventState extends State<PaidEvent> {
  final Location _location = Location();
  Future<LocationData?>? _locationFuture;

  @override
  void initState() {
    super.initState();
    _locationFuture = _getLocation();
  }

  Future<LocationData?> _getLocation() async {
    if (!(await _location.serviceEnabled()) &&
        !(await _location.requestService())) {
      return null;
    }
    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return null;
      }
    }
    return _location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: _buildEventImage(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 290),
              child: _buildCurvedContainer(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 20),
        child: _buildJoinButton(),
      ),
    );
  }

  Widget _buildEventImage() {
    return Image.asset(
      'assets/images/payedImg.jpg',
      width: double.infinity,
      fit: BoxFit.cover,
      height: 350,
    );
  }

  Widget _buildCurvedContainer() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(60),
        topRight: Radius.circular(60),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        color: Colors.white,
        child: _buildEventContent(),
      ),
    );
  }

  Widget _buildEventContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildEventTitle(),
        const SizedBox(height: 10),
        _buildHostName(),
        const SizedBox(height: 10),
        _buildDescription(),
        const Divider(color: Colors.grey, thickness: 1),
        _buildEventDetails(),
        const SizedBox(height: 30),
        _buildLocationSection(),
        const SizedBox(height: 20),
        _buildPreviousEvent(),
      ],
    );
  }

  Widget _buildEventTitle() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          iconSize: 24,
        ),
        const SizedBox(width: 8),
        Text(
          'Event Name',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        const SizedBox(width: 50),
        Flexible(
          child: Text(
            '100.00 EGP',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildHostName() {
    return Row(
      children: const [
        Icon(Icons.circle, size: 30, color: Color.fromARGB(255, 92, 92, 92)),
        SizedBox(width: 5),
        Text('Host Name', style: TextStyle(color: Colors.black, fontSize: 15)),
      ],
    );
  }

  Widget _buildDescription() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildEventDetails() {
    return Column(
      children: [
        _buildEventDetailsRow(Icons.access_time, '9:00 PM'),
        const SizedBox(height: 20),
        _buildEventDetailsRow(Icons.computer_outlined, 'AI Event'),
        const SizedBox(height: 20),
        _buildEventDetailsRow(Icons.calendar_today_outlined, '25 NOV, 25'),
      ],
    );
  }

  Widget _buildEventDetailsRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.red[900]),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: FutureBuilder<LocationData?>(
            future: _locationFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text("Location not available"));
              }
              final data = snapshot.data!;
              return Center(
                child: Text(
                  "Lat: ${data.latitude?.toStringAsFixed(4)}\nLng: ${data.longitude?.toStringAsFixed(4)}",
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPreviousEvent() {
    return const Center(
      child: Image(
        image: AssetImage('assets/images/ErrImage.jpg'),
        height: 150,
      ),
    );
  }

  Widget _buildJoinButton() {
    return SizedBox(
      height: 50,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => PaymentOptionsScreen()));
          },
          style: ElevatedButton.styleFrom(
            elevation: 5,
            padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Color.fromARGB(255, 197, 38, 125),
                width: 1.5,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          child: const Text(
            'Continue to Payment',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
