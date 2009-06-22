# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{twilio}
  s.version = "1.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Phil Misiowiec"]
  s.date = %q{2009-06-21}
  s.email = %q{github@webficient.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/twilio.rb",
    "lib/twilio/account.rb",
    "lib/twilio/call.rb",
    "lib/twilio/connection.rb",
    "lib/twilio/incoming_phone_number.rb",
    "lib/twilio/local_phone_number.rb",
    "lib/twilio/notification.rb",
    "lib/twilio/outgoing_caller_id.rb",
    "lib/twilio/recording.rb",
    "lib/twilio/toll_free_phone_number.rb",
    "lib/twilio/twilio_object.rb",
    "lib/twilio/verb.rb",
    "test/fixtures/xml/account.xml",
    "test/fixtures/xml/account_renamed.xml",
    "test/fixtures/xml/call.xml",
    "test/fixtures/xml/call_new.xml",
    "test/fixtures/xml/calls.xml",
    "test/fixtures/xml/incoming_phone_number.xml",
    "test/fixtures/xml/incoming_phone_numbers.xml",
    "test/fixtures/xml/notification.xml",
    "test/fixtures/xml/notifications.xml",
    "test/fixtures/xml/outgoing_caller_id.xml",
    "test/fixtures/xml/outgoing_caller_id_new.xml",
    "test/fixtures/xml/outgoing_caller_ids.xml",
    "test/fixtures/xml/recording.xml",
    "test/fixtures/xml/recordings.xml",
    "test/fixtures/xml/transcription.xml",
    "test/fixtures/xml/transcriptions.xml",
    "test/fixtures/yml/verb_responses.yml",
    "test/test_helper.rb",
    "test/twilio/account_test.rb",
    "test/twilio/call_test.rb",
    "test/twilio/connection_test.rb",
    "test/twilio/incoming_phone_number_test.rb",
    "test/twilio/local_phone_number_test.rb",
    "test/twilio/notification_test.rb",
    "test/twilio/outgoing_caller_id_test.rb",
    "test/twilio/recording_test.rb",
    "test/twilio/toll_free_phone_number_test.rb",
    "test/twilio/verb_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/webficient/twilio}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Twilio API Client}
  s.test_files = [
    "test/test_helper.rb",
    "test/twilio/account_test.rb",
    "test/twilio/call_test.rb",
    "test/twilio/connection_test.rb",
    "test/twilio/incoming_phone_number_test.rb",
    "test/twilio/local_phone_number_test.rb",
    "test/twilio/notification_test.rb",
    "test/twilio/outgoing_caller_id_test.rb",
    "test/twilio/recording_test.rb",
    "test/twilio/toll_free_phone_number_test.rb",
    "test/twilio/verb_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
    else
      s.add_dependency(%q<builder>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0"])
    end
  else
    s.add_dependency(%q<builder>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0"])
  end
end
