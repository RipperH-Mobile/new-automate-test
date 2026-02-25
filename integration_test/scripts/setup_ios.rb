begin
  require 'xcodeproj'
rescue LoadError
  puts "📦 'xcodeproj' gem not found. Installing locally..."
  system('gem install xcodeproj --user-install --no-document')
  Gem.clear_paths
  require 'xcodeproj'
end

require 'fileutils'

class PodfileReader
  def self.get_ios_version(podfile_path)
    unless File.exist?(podfile_path)
      puts "⚠️ Warning: Podfile not found at #{podfile_path}. Using default 14.0"
      return '14.0'
    end

    content = File.read(podfile_path)
    match = content.match(/platform\s+:ios\s*,\s*['"]([^'"]+)['"]/)

    if match
      version = match[1]
      puts "👀 Detected iOS Version from Podfile: #{version}"
      return version
    else
      puts "⚠️ Warning: Could not find 'platform :ios' in Podfile. Using default 14.0"
      return '14.0'
    end
  end
end

class SetupIOS
  def initialize
    @project_path   = 'ios/Runner.xcodeproj'
    @target_name    = 'RunnerUITests'
    @group_name     = 'RunnerUITests'
    @file_name      = 'RunnerUITests.m'
    @target_schemes = ['dev', 'sit', 'uat']
    @target_ios_version = PodfileReader.get_ios_version('ios/Podfile')
  end

  def run
    unless File.directory?(@project_path)
      puts "❌ Error: Project not found at #{@project_path}"
      exit 1
    end

    puts "🍎 Opening Xcode Project: #{@project_path}"
    @project = Xcodeproj::Project.open(@project_path)

    # 1. จัดการ Target
    if target_exists?
      puts "   ✅ Target '#{@target_name}' exists. Updating settings..."
      target = @project.targets.find { |t| t.name == @target_name }
      configure_build_settings(target)
    else
      create_and_configure_target
      puts "   ✅ Xcode Target setup complete."
    end
    
    # 2. Update Runner (Main App) ให้ตรงกับ Podfile ด้วย (ป้องกัน Warning)
    update_runner_target_version

    # 3. Save Changes
    @project.save
    puts "🎉 iOS Setup Finished! (Synced with Podfile version: #{@target_ios_version})"
    
    # 4. Reminder Check
    check_podfile_integration
  end

  private

  def target_exists?
    @project.targets.map(&:name).include?(@target_name)
  end

  def find_runner_target
    @project.targets.find { |t| t.name == 'Runner' }
  end

  def update_runner_target_version
    puts "   🔨 Syncing 'Runner' target to version #{@target_ios_version}..."
    runner = find_runner_target
    runner.build_configurations.each do |config|
      # ตั้งค่าให้ตรงกับ Podfile เป๊ะๆ
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = @target_ios_version
    end
  end

  def create_and_configure_target
    puts "   🔨 Creating new target: #{@target_name}..."
    runner_target = find_runner_target
    
    target = @project.new_target(:ui_test_bundle, @target_name, :ios)
    target.add_dependency(runner_target)
    
    add_files_to_project(target)
    sync_build_configurations(target, runner_target)
    configure_build_settings(target)
    configure_schemes(target)
  end

  def add_files_to_project(target)
    Dir.mkdir("ios/#{@group_name}") unless Dir.exist?("ios/#{@group_name}")
    file_path = "ios/#{@group_name}/#{@file_name}"
    
    unless File.exist?(file_path)
      File.write(file_path, <<~EOF
@import XCTest;
@import patrol;
@import ObjectiveC.runtime;

PATROL_INTEGRATION_TEST_IOS_RUNNER(RunnerUITests)
EOF
      )
    end

    group = @project.main_group[@group_name] || @project.main_group.new_group(@group_name, @group_name)
    file_ref = group.find_file_by_path(@file_name) || group.new_file(@file_name)
    target.add_file_references([file_ref])
  end

  def sync_build_configurations(target, runner_target)
    needed_configs = runner_target.build_configurations.map(&:name)
    needed_configs.each do |conf_name|
      unless target.build_configurations.any? { |c| c.name == conf_name }
        base_name = conf_name.downcase.include?('release') ? 'Release' : 'Debug'
        base_config = target.build_configurations.find { |c| c.name == base_name } || target.build_configurations.first
        new_config = @project.new(Xcodeproj::Project::Object::XCBuildConfiguration)
        new_config.name = conf_name
        new_config.build_settings = base_config.build_settings.clone
        target.build_configurations << new_config
      end
    end
    target.build_configurations.delete_if { |c| !needed_configs.include?(c.name) }
  end

  def configure_build_settings(target)
    runner_target = find_runner_target
    runner_bs = runner_target.build_configurations.first.build_settings
    base_bundle_id = runner_bs['PRODUCT_BUNDLE_IDENTIFIER'] || 'com.example.app'

    target.build_configurations.each do |config|
      config.build_settings['PRODUCT_NAME'] = '$(TARGET_NAME)'
      config.build_settings['TEST_TARGET_NAME'] = 'Runner'
      config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = "#{base_bundle_id}.RunnerUITests"
      
      # 🔥 ใช้ค่า Version ที่อ่านมาจาก Podfile
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = @target_ios_version
      
      config.build_settings['GENERATE_INFOPLIST_FILE'] = 'YES'
      config.build_settings['CODE_SIGN_STYLE'] = 'Automatic'
      
      # 🛡️ ป้องกัน Crash: Duplicate Library
      config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
      
      config.build_settings['FRAMEWORK_SEARCH_PATHS'] = ['$(inherited)', '$(PROJECT_DIR)/Flutter']
    end
  end

  def configure_schemes(target)
    puts "   ⚙️  Configuring Schemes..."
    @target_schemes.each do |scheme_name|
      scheme_path = Xcodeproj::XCScheme.shared_data_dir(@project_path) + "#{scheme_name}.xcscheme"
      unless File.exist?(scheme_path)
        user_scheme_path = Xcodeproj::XCScheme.user_data_dir(@project_path) + "#{scheme_name}.xcscheme"
        scheme_path = user_scheme_path if File.exist?(user_scheme_path)
      end

      if File.exist?(scheme_path)
        scheme = Xcodeproj::XCScheme.new(scheme_path)
        scheme.test_action = Xcodeproj::XCScheme::TestAction.new if scheme.test_action.nil?

        entry = scheme.test_action.testables.find { |t| t.buildable_references.first.target_name == @target_name }
        if entry.nil?
          ref = Xcodeproj::XCScheme::TestAction::TestableReference.new(target)
          scheme.test_action.add_testable(ref)
          scheme.save!
        end
      end
    end
  end

  def check_podfile_integration
    # แค่เช็คและแจ้งเตือน ไม่แก้ไขไฟล์
    podfile_content = File.read('ios/Podfile')
    unless podfile_content.include?("target 'RunnerUITests'")
      puts "\n⚠️  [ACTION REQUIRED] ⚠️"
      puts "   RunnerUITests is set up in Xcode, BUT it is missing from your Podfile."
      puts "   Since we are restricted from modifying the Podfile, please add this manually:"
      puts "   ---------------------------------------------------"
      puts "   target 'RunnerUITests' do"
      puts "     inherit! :complete"
      puts "   end"
      puts "   ---------------------------------------------------"
      puts "   Then run: cd ios && pod install"
    end
  end
end

SetupIOS.new.run