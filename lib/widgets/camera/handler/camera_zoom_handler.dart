import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

final _log = useLogger();

class CameraZoomHandler {
  // Variables for storing different scale values
  double _baseZoomLevel = 1.0; // Initial zoom value when starting gesture
  double _currentZoomLevel = 1.0; // Current zoom value
  double _minZoomLevel = 1.0; // Minimum allowed zoom value
  double _maxZoomLevel = 8.0; // Maximum allowed zoom value

  // Variables for pan gesture handling
  double _panStartY = 0.0; // Starting Y position for pan gesture
  double _panStartZoom = 1.0; // Starting zoom level for pan gesture
  double _panSensitivity = 0.005; // Pan sensitivity for zoom control

  // Getters for accessing current zoom level values
  double get currentZoomLevel => _currentZoomLevel;
  double get minZoomLevel => _minZoomLevel;
  double get maxZoomLevel => _maxZoomLevel;

  /// Function for initializing zoom levels
  /// Called after camera controller has been initialized
  Future<void> initializeZoomLevels(CameraController cameraController) async {
    try {
      _minZoomLevel = await cameraController.getMinZoomLevel();
      _maxZoomLevel = await cameraController.getMaxZoomLevel();
      _currentZoomLevel = _minZoomLevel;
      _baseZoomLevel = _minZoomLevel;

      // Set initial zoom level
      await cameraController.setZoomLevel(_currentZoomLevel);
    } catch (e, stack) {
      _log.e('Failed to initialize zoom', e, stack);
    }
  }

  /// Function called when scale gesture starts (onScaleStart)
  /// Records current zoom value as base for calculations
  void handleScaleStart() {
    _baseZoomLevel = _currentZoomLevel;
  }

  /// Main function for handling scale gesture (onScaleUpdate)
  /// Calculates new zoom value and updates camera
  Future<void> handleScaleUpdate(
    double scale,
    CameraController cameraController, {
    VoidCallback? onZoomChanged,
  }) async {
    // Check if camera is ready for use
    if (!cameraController.value.isInitialized) return;

    try {
      // Calculate new zoom value from scale gesture
      double newZoomLevel = _baseZoomLevel * scale;

      // Clamp value to allowed range
      newZoomLevel = newZoomLevel.clamp(_minZoomLevel, _maxZoomLevel);

      // Update value only when there's significant change
      if ((_currentZoomLevel - newZoomLevel).abs() > 0.1) {
        _currentZoomLevel = newZoomLevel;

        // Apply zoom to camera
        cameraController.setZoomLevel(_currentZoomLevel);

        // Callback for updating UI if needed
        onZoomChanged?.call();
      }
    } catch (e, s) {
      _log.e('Failed to update zoom level via scale gesture', e, s);
    }
  }

  /// Function called when pan gesture starts (onPanStart)
  /// Records starting position and zoom level for pan-to-zoom functionality
  void handlePanStart(DragStartDetails details) {
    _panStartY = details.globalPosition.dy;
    _panStartZoom = _currentZoomLevel;
  }

  /// Function called during pan gesture (onPanUpdate)
  /// Handles vertical pan gestures to control zoom
  /// Pan up = zoom in, Pan down = zoom out
  Future<void> handlePanUpdate(
    DragUpdateDetails details,
    CameraController cameraController, {
    VoidCallback? onZoomChanged,
  }) async {
    // Check if camera is ready for use
    if (!cameraController.value.isInitialized) return;

    try {
      // Calculate vertical distance moved
      double deltaY = _panStartY - details.globalPosition.dy;

      // Calculate new zoom level based on vertical movement
      // Positive deltaY (pan up) = zoom in
      // Negative deltaY (pan down) = zoom out
      double newZoomLevel = _panStartZoom + (deltaY * _panSensitivity);

      // Clamp value to allowed range
      newZoomLevel = newZoomLevel.clamp(_minZoomLevel, _maxZoomLevel);

      // Update value only when there's significant change
      if ((_currentZoomLevel - newZoomLevel).abs() > 0.05) {
        _currentZoomLevel = newZoomLevel;

        // Apply zoom to camera
        cameraController.setZoomLevel(_currentZoomLevel);

        // Callback for updating UI if needed
        onZoomChanged?.call();

        // Light haptic feedback for smooth zoom experience
        HapticFeedback.selectionClick();
      }
    } catch (e, s) {
      _log.e('Failed to update zoom level via pan gesture', e, s);
    }
  }

  /// Function called when pan gesture ends (onPanEnd)
  /// Finalizes pan-to-zoom operation
  void handlePanEnd(DragEndDetails details) {
    // Update base zoom level to current level for future gestures
    _baseZoomLevel = _currentZoomLevel;

    // Medium haptic feedback to indicate gesture completion
    HapticFeedback.mediumImpact();
  }

  /// Function called when scale gesture ends (onScaleEnd)
  /// Finalizes zoom value
  void handleScaleEnd() {
    // Could add haptic feedback or animation here
  }

  /// Function for resetting zoom back to 1x zoom step
  /// Called when reset is needed or double tap occurs
  Future<void> resetZoom(CameraController cameraController, {VoidCallback? onZoomChanged}) async {
    if (!cameraController.value.isInitialized) return;

    try {
      _currentZoomLevel = _minZoomLevel;
      _baseZoomLevel = _minZoomLevel;

      await cameraController.setZoomLevel(_currentZoomLevel);
      onZoomChanged?.call();
    } catch (e, s) {
      _log.e('Failed to reset zoom to 1x', e, s);
    }
  }

  /// Function for formatting zoom level as string for UI display
  String getZoomDisplayText() {
    return '${_currentZoomLevel.toStringAsFixed(1)}x';
  }

  /// Function for getting zoom as percentage (0-100%)
  int getZoomPercentage() {
    if (_maxZoomLevel <= _minZoomLevel) return 0;

    double percentage = ((_currentZoomLevel - _minZoomLevel) / (_maxZoomLevel - _minZoomLevel)) * 100;
    return percentage.round().clamp(0, 100);
  }

  /// Function for setting pan sensitivity
  /// Higher values make pan gestures more sensitive to movement
  void setPanSensitivity(double sensitivity) {
    // Clamp sensitivity to reasonable range (0.001 to 0.02)
    _panSensitivity = sensitivity.clamp(0.001, 0.02);
  }

  /// Function to get current pan sensitivity
  double getPanSensitivity() {
    return _panSensitivity;
  }

  /// Function to check if zoom level can be increased
  bool canZoomIn() {
    return _currentZoomLevel < _maxZoomLevel;
  }

  /// Function to check if zoom level can be decreased
  bool canZoomOut() {
    return _currentZoomLevel > _minZoomLevel;
  }

  /// Function for getting current zoom level as x size format
  /// Returns the actual zoom level with 'x' suffix for display
  String getCurrentZoomLevel() {
    return '${(_currentZoomLevel).toStringAsFixed(1)}x';
  }

  /// Function for getting raw zoom level value
  /// Returns the actual numeric zoom level without formatting
  double getCurrentZoomValue() {
    return _currentZoomLevel;
  }
}
