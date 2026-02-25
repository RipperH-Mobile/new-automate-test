# CLAUDE Assistant Instructions

## Documentation Language
**IMPORTANT**: All documentation, comments, and technical writing must be in **English only**. This includes:
- Code comments
- Documentation files (.md)
- TODO items and task descriptions
- Technical specifications
- Implementation plans
- API documentation
- README files

The only exception is when dealing with existing Thai text in the UI or user-facing strings.

## Flutter Version Management (FVM)

This project uses FVM (Flutter Version Management) to ensure consistent Flutter SDK versions across all environments.

**IMPORTANT**: Always use `fvm flutter` instead of `flutter` for all Flutter commands.

### Examples:
```bash
# CORRECT - Use these commands:
fvm flutter pub get
fvm flutter run
fvm flutter test
fvm flutter build ios
fvm flutter build apk
fvm flutter clean
fvm flutter analyze
fvm flutter format .

# INCORRECT - Do NOT use:
flutter pub get
flutter run
flutter test
```

### For Dart commands, use:
```bash
fvm dart run build_runner build
fvm dart format .
fvm dart analyze
```

## Bash Scripts and Tools

When creating bash scripts or development tools:
- **ALWAYS** create them in the `.tools/` directory
- Make scripts executable with `chmod +x`
- Add clear descriptions and usage instructions in the script

### Example:
```bash
# Create script in .tools directory
.tools/my_script.sh

# Make it executable
chmod +x .tools/my_script.sh
```

### Current tools available:
- `.tools/clean_rebuild.sh` - Clean and rebuild Flutter project with all dependencies

## Running Tests

When running unit tests, always use FVM:
```bash
# Run specific test file
fvm flutter test test/core/data/data_sources/remote/app_version_http_data_source_test.dart

# Run all tests
fvm flutter test

# Run tests with coverage
fvm flutter test --coverage
```

## Common Flutter Tasks

### Dependency Management
```bash
# Get dependencies
fvm flutter pub get

# Upgrade dependencies
fvm flutter pub upgrade

# Clean and get dependencies
fvm flutter clean && fvm flutter pub get
```

### Code Generation
```bash
# Run build_runner
fvm dart run build_runner build --delete-conflicting-outputs

# Watch for changes
fvm dart run build_runner watch --delete-conflicting-outputs
```

### Code Quality
```bash
# Analyze code
fvm flutter analyze

# Format code
fvm dart format .

# Fix linting issues
fvm dart fix --apply
```

## Build and Deployment Policy

**IMPORTANT**: Do NOT run build commands after implementation completion unless explicitly requested by the user.

### Restricted Commands
- `fvm flutter build apk`
- `fvm flutter build ios`
- `fvm flutter build web`
- `fvm flutter build windows`
- `fvm flutter build macos`
- `fvm flutter build linux`

### Verification Commands (ALLOWED)
```bash
# Analyze code for errors
fvm flutter analyze

# Test compilation without building
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs

# Run tests
fvm flutter test
```

### When Build is Required
Only run build commands when:
1. User explicitly requests build
2. Testing deployment configuration
3. Troubleshooting build-specific issues

### Post-Implementation Verification
After completing implementation:
1. ✅ Run `fvm flutter analyze` to check for errors
2. ✅ Run `fvm flutter pub get` to ensure dependencies
3. ✅ Verify key files compile without errors
4. ❌ **DO NOT** run build commands automatically

## Deprecated Methods and Flutter Core Library Policy

**IMPORTANT**: Always avoid using deprecated methods and functions from Flutter core libraries to ensure code longevity and maintainability.

### Checking for Deprecated Usage
```bash
# Check for deprecated methods in Flutter analysis
fvm flutter analyze | grep -i "deprecated"

# Check for specific deprecated patterns
fvm flutter analyze | grep -E "deprecated_member_use|deprecated_member_use_from_same_package"
```

### Common Deprecated Methods to Avoid

#### 1. Color Operations
```dart
// ❌ DEPRECATED - Use .withValues() instead
Colors.red.withOpacity(0.5)

// ✅ MODERN - Use .withValues() for precision
Colors.red.withValues(alpha: 0.5)
```

#### 2. Share Operations
```dart
// ❌ DEPRECATED - Old Share class
Share.share(text)
Share.shareXFiles(files)

// ✅ MODERN - Use SharePlus.instance
SharePlus.instance.share(text)
SharePlus.instance.shareXFiles(files)
```

#### 3. Widget Constructor Parameters
```dart
// ❌ DEPRECATED - Manual key parameter
class MyWidget extends StatelessWidget {
  MyWidget({Key? key, required this.data}) : super(key: key);
}

// ✅ MODERN - Super parameter
class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.data});
}
```

#### 4. Layout Widgets
```dart
// ❌ DEPRECATED - Container for spacing
Container(height: 16, child: widget)

// ✅ MODERN - SizedBox for spacing
SizedBox(height: 16, child: widget)
```

### Replacement Guidelines

#### Before Implementation
1. **Check Flutter Documentation**: Always verify latest API usage
2. **Use IDE Warnings**: Pay attention to strikethrough text and warnings
3. **Check Migration Guides**: Follow official Flutter migration guides

#### During Implementation
1. **Use Modern Alternatives**: Always prefer the newest non-deprecated API
2. **Check Package Versions**: Ensure using latest stable versions
3. **Test with Analysis**: Run `fvm flutter analyze` frequently

#### Code Review Checklist
- [ ] No deprecated member usage warnings
- [ ] All Color operations use `.withValues()`
- [ ] Share operations use `SharePlus.instance`
- [ ] Widget constructors use super parameters
- [ ] Layout uses `SizedBox` instead of empty `Container`

### Migration Strategy
When encountering deprecated methods:

1. **Identify Replacement**: Check Flutter docs for modern alternative
2. **Update Gradually**: Replace deprecated usage systematically
3. **Test Thoroughly**: Ensure functionality remains the same
4. **Document Changes**: Note what was changed and why

### Example Migration
```dart
// Before (deprecated)
Container(
  color: Colors.blue.withOpacity(0.1),
  child: Text('Hello'),
)

// After (modern)
Container(
  color: Colors.blue.withValues(alpha: 0.1),
  child: const Text('Hello'),
)
```

### Tools and Resources
- **Flutter Docs**: https://docs.flutter.dev/
- **Migration Guide**: Check Flutter release notes
- **Analyzer**: Use `fvm flutter analyze` regularly
- **IDE Support**: Enable all deprecation warnings

## TODO Plan Documentation Standards

When creating TODO plans and implementation documentation:

### Structure Format
- Use **Phase-based organization** instead of time-based (Week 1, Week 2, etc.)
- Number tasks as **TODO {phase}.{task}** (e.g., TODO 1.1, TODO 2.3)
- Include **Priority levels**: HIGH, MEDIUM, LOW
- Add **Milestone** for each phase completion

### Phase Template
```markdown
### Phase {n}: {Phase Name} ({Priority} Priority)
- [ ] TODO {n}.1: {Task description}
- [ ] TODO {n}.2: {Task description}
- [ ] TODO {n}.3: {Task description}
- [ ] **Milestone**: {Clear completion criteria}
```

### Example Implementation Phases
```markdown
### Phase 1: Core Implementation (HIGH Priority)
- [ ] TODO 1.1: Create core classes and interfaces
- [ ] TODO 1.2: Implement basic functionality
- [ ] **Milestone**: Basic functionality working

### Phase 2: Integration (HIGH Priority)
- [ ] TODO 2.1: Integrate with existing systems
- [ ] TODO 2.2: Add hooks and event handling
- [ ] **Milestone**: Integration complete and tested
```

### Documentation Organization
- **Overview**: Clear problem statement and goals
- **TODO Tasks**: Organized by phases with checkboxes
- **Priority Order**: Clear priority levels for each phase
- **Files Section**: List of files to create/modify
- **Integration Points**: Specific locations and line numbers
- **Benefits**: Clear value proposition
- **Implementation Phases**: Flexible, task-focused timeline

This ensures consistent, actionable TODO plans that are easy to track and execute.

## Implementation Documentation Standards

When completing implementation based on documentation:

### Post-Implementation Requirements
After completing an implementation that follows a TODO plan or documentation:

1. **Update Documentation Immediately**: Mark all completed tasks as done with checkboxes [x]
2. **Add Implementation Details**: Include:
   - Actual file paths created/modified
   - Line numbers for key changes
   - Any deviations from original plan
   - Test coverage information
3. **Add Usage Guide**: Provide examples of how to use the new feature
4. **Update Timeline**: Add completion dates for phases

### Documentation Update Template
```markdown
## Implementation Status
### ✅ COMPLETED (YYYY-MM-DD)
- [x] Task description
- [x] Implementation details with file locations

## Usage Guide
### How to Access/Use
```dart
// Code examples
```

### Monitor Output Examples
```
// Sample output
```

## Completed Implementation Details
### Phase Name ✅
- What was implemented
- File locations and line numbers
- Key methods/classes
- Test coverage
```

### Example: Message Queue Monitor
When implementing features like monitoring systems:
1. Follow the TODO plan in documentation
2. Update relevant .md files immediately after implementation
3. Mark completed tasks with checkboxes
4. Add usage examples and debug output samples
5. Include test file locations and coverage info

### Best Practices
- Always update docs in the same commit or immediately after implementation
- Include real output examples from testing
- Document any limitations or known issues
- Add references to test files for validation