require 'capybara/rspec'
require 'headless'
require 'selenium-webdriver'

ENV['UAT_TEST_NUMBER'] ||= "#{ (ENV['TEST_ENV_NUMBER']!='' ? ENV['TEST_ENV_NUMBER'] : 1).to_i }"

headless = Headless.new(
  display: "#{ 100 + ENV['UAT_TEST_NUMBER'].to_i }",
  reuse: true,
  video: {
    provider:   :ffmpeg,
    frame_rate: 12,
    codec:      :libx264,
    pid_file_name:  "/tmp/.headless_ffmpeg_#{ENV['UAT_TEST_NUMBER']}.pid",
    tmp_file_name:  "/tmp/.headless_ffmpeg_#{ENV['UAT_TEST_NUMBER']}.pid"
  }
) if ENV['HEADLESS']

Capybara.run_server = false;
Capybara.default_driver = :selenium

RSpec.configure do |c|
  c.before(:suite) do
    if (ENV['HEADLESS'])
      p 'Starting Headless...'
      headless.start
    end
  end
  
  c.after(:suite) do
    if (ENV['HEADLESS'])
      headless.destroy
    end
  end
  
  c.before(:each) do
    headless.video.start_capture if ENV['HEADLESS']
  end
  
  c.after(:each) do |e|
    headless.video.stop_and_save "video/video_#{ENV['UAT_TEST_NUMBER']}_#{File.basename(e.metadata[:file_path])}.mov" if ENV['HEADLESS']
    #headless.video.stop_and_discard
  end
end
