import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/services/event_service.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';
import 'package:smart_event_planner/features/payment/screens/payment_options_screen.dart';
// ignore_for_file: deprecated_member_use

class PaidEvent extends StatefulWidget {
  final EventModel event;

  const PaidEvent({super.key, required this.event});

  @override
  State<PaidEvent> createState() => _PaidEventState();
}

class _PaidEventState extends State<PaidEvent> {
  late Future<LocationData?> _locationFuture;
  final ScrollController _scrollController = ScrollController();
  final EventService _eventService = EventService();
  List<EventModel> previousEvents = [];
  bool isLoadingPreviousEvents = false;

  @override
  void initState() {
    super.initState();
    _locationFuture = _getLocation();
    _loadPreviousEvents();
  }

  Future<void> _loadPreviousEvents() async {
    setState(() => isLoadingPreviousEvents = true);
    try {
      final events = await _eventService.getEvents();
      setState(() {
        previousEvents = events
            .where(
                (e) => e.id != widget.event.id && e.host == widget.event.host)
            .toList();
        isLoadingPreviousEvents = false;
      });
    } catch (e) {
      setState(() => isLoadingPreviousEvents = false);
    }
  }

  Future<LocationData?> _getLocation() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }

    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) return null;
    }

    return await location.getLocation();
  }

  String _getImageUrl() {
    if (widget.event.imageUrl != null && widget.event.imageUrl!.isNotEmpty) {
      if (widget.event.imageUrl!.startsWith('http')) {
        return widget.event.imageUrl!;
      }
      return 'https://eventplanner-production-ce6e.up.railway.app${widget.event.imageUrl!.startsWith('/') ? '' : '/'}${widget.event.imageUrl!}';
    }
    return 'assets/images/payedImg.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final imageUrl = _getImageUrl();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.event.title ?? 'Event',
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        actions: [
          IconButton(
            icon:
                Icon(Iconsax.star, color: isDark ? Colors.white : Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon:
                Icon(Icons.share, color: isDark ? Colors.white : Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 300,
              child: imageUrl.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        height: 300,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/payedImg.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) => false,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.only(top: 250),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.event.title ?? 'Event Title',
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                              const SizedBox(width: 16),
                              widget.event.paid == false ||
                                      widget.event.price == '0.00'
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: AppColors.greenColor
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Free',
                                        style: TextStyle(
                                          color: AppColors.greenColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      '${widget.event.price ?? '100.00'} EGP',
                                      style: const TextStyle(
                                        color: AppColors.greenColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.account_circle,
                                  size: 30, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(
                                widget.event.host ?? 'Host Name',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Description',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.event.description ??
                                'No description available',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 24),
                          const Divider(height: 1),
                          const SizedBox(height: 24),
                          _buildEventDetails(theme),
                          const SizedBox(height: 32),
                          _buildLocationSection(theme),
                          const SizedBox(height: 32),
                          _buildPreviousEventsSection(theme),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentOptionsScreen(event: widget.event),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Continue to Payment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventDetails(ThemeData theme) {
    return Column(
      children: [
        _buildDetailRow(Icons.access_time,
            widget.event.time ?? 'Time not specified', theme),
        const SizedBox(height: 16),
        _buildDetailRow(Icons.category,
            widget.event.category ?? 'Category not specified', theme),
        const SizedBox(height: 16),
        _buildDetailRow(
            Icons.calendar_today, _formatDate(widget.event.date), theme),
      ],
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Date not specified';
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildDetailRow(IconData icon, String text, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 24, color: AppColors.primaryColor),
        const SizedBox(width: 12),
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FutureBuilder<LocationData?>(
            future: _locationFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://maps.googleapis.com/maps/api/staticmap?center=${widget.event.location?.lat},${widget.event.location?.lng}&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7C${widget.event.location?.lat},${widget.event.location?.lng}&key=https://eventplanner-production-ce6e.up.railway.app/api/events/getevents',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/images/test_map.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.event.location?.name ?? 'Location not specified',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPreviousEventsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Previous Events',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        isLoadingPreviousEvents
            ? const Center(child: CircularProgressIndicator())
            : previousEvents.isEmpty
                ? Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'No previous events available',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: previousEvents.length,
                      itemBuilder: (context, index) {
                        final event = previousEvents[index];
                        return Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: event.imageUrl != null
                                  ? NetworkImage(event.imageUrl!)
                                  : const AssetImage(
                                          'assets/images/payedImg.jpg')
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.title ?? 'Event',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatDate(event.date),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ],
    );
  }
}
