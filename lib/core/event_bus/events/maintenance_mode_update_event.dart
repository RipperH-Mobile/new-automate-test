class MaintenanceModeUpdateEvent {
  bool isMaintenanceOn;

  MaintenanceModeUpdateEvent({required this.isMaintenanceOn});

  @override
  String toString() => 'MaintenanceModeUpdateEvent(isMaintenanceOn: $isMaintenanceOn)';
}
