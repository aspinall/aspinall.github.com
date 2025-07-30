#!/usr/bin/env ruby
# Test suite for Hugo site setup and configuration

require 'yaml'
require 'json'

class HugoSetupTests
  def initialize
    @errors = []
    @passed = 0
    @total = 0
  end

  def run_all_tests
    puts "🔍 Running Hugo Setup Tests..."
    puts "=" * 50
    
    test_hugo_binary_exists
    test_config_toml_exists
    test_config_toml_has_required_settings
    test_directory_structure_exists
    test_index_file_exists
    test_posts_directory_exists
    test_site_builds_successfully
    
    report_results
  end

  private

  def test_hugo_binary_exists
    @total += 1
    if system('which hugo > /dev/null 2>&1')
      pass("✅ Hugo binary is available")
    else
      fail("❌ Hugo binary is not installed or not in PATH")
    end
  end

  def test_config_toml_exists
    @total += 1
    config_files = ['hugo.toml', 'config.toml', 'hugo.yaml', 'config.yaml']
    exists = config_files.any? { |file| File.exist?(file) }
    
    if exists
      found_file = config_files.find { |file| File.exist?(file) }
      pass("✅ Hugo config exists: #{found_file}")
    else
      fail("❌ No Hugo config found (looking for: #{config_files.join(', ')})")
    end
  end

  def test_config_toml_has_required_settings
    @total += 1
    config_files = ['hugo.toml', 'config.toml', 'hugo.yaml', 'config.yaml']
    config_file = config_files.find { |file| File.exist?(file) }
    
    return fail("❌ Cannot test config - no config file exists") unless config_file
    
    begin
      if config_file.end_with?('.toml')
        # Simple TOML parsing for basic settings
        config_content = File.read(config_file)
        required_settings = ['title', 'baseURL']
        missing_settings = []
        
        required_settings.each do |setting|
          unless config_content.include?(setting)
            missing_settings << setting
          end
        end
        
        if missing_settings.empty?
          pass("✅ #{config_file} has required settings: #{required_settings.join(', ')}")
        else
          fail("❌ #{config_file} missing settings: #{missing_settings.join(', ')}")
        end
      else
        # YAML config
        config = YAML.load_file(config_file)
        required_settings = ['title', 'baseURL']
        missing_settings = []
        
        required_settings.each do |setting|
          unless config.key?(setting)
            missing_settings << setting
          end
        end
        
        if missing_settings.empty?
          pass("✅ #{config_file} has required settings: #{required_settings.join(', ')}")
        else
          fail("❌ #{config_file} missing settings: #{missing_settings.join(', ')}")
        end
      end
    rescue => e
      fail("❌ #{config_file} is not valid: #{e.message}")
    end
  end

  def test_directory_structure_exists
    @total += 1
    required_dirs = ['content', 'layouts', 'static']
    missing_dirs = []
    
    required_dirs.each do |dir|
      unless Dir.exist?(dir)
        missing_dirs << dir
      end
    end
    
    if missing_dirs.empty?
      pass("✅ Required directories exist: #{required_dirs.join(', ')}")
    else
      fail("❌ Missing directories: #{missing_dirs.join(', ')}")
    end
  end

  def test_index_file_exists
    @total += 1
    index_files = ['content/_index.md', 'content/index.md']
    exists = index_files.any? { |file| File.exist?(file) }
    
    if exists
      pass("✅ Index file exists")
    else
      fail("❌ No index file found (looking for: #{index_files.join(', ')})")
    end
  end

  def test_posts_directory_exists
    @total += 1
    if Dir.exist?('content/posts')
      pass("✅ content/posts directory exists")
    else
      fail("❌ content/posts directory does not exist")
    end
  end

  def test_site_builds_successfully
    @total += 1
    # This test will be run after Hugo is set up
    if system('hugo --quiet > /dev/null 2>&1')
      pass("✅ Hugo site builds successfully")
    else
      fail("❌ Hugo site fails to build")
    end
  end

  def pass(message)
    @passed += 1
    puts message
  end

  def fail(message)
    @errors << message
    puts message
  end

  def report_results
    puts "=" * 50
    puts "Test Results: #{@passed}/#{@total} passed"
    
    if @errors.empty?
      puts "🎉 All tests passed!"
      exit 0
    else
      puts "❌ #{@errors.length} test(s) failed"
      puts "Failed tests:"
      @errors.each { |error| puts "  #{error}" }
      exit 1
    end
  end
end

# Run tests if this file is executed directly
if __FILE__ == $0
  HugoSetupTests.new.run_all_tests
end