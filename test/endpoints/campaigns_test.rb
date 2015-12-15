module PortaText
  module Test
    module Endpoints
      # Tests the campaigns endpoint.
      #
      # Author::    Marcelo Gornstein (mailto:marcelog@portatext.com)
      # Copyright:: Copyright (c) 2015 PortaText
      # License::   Apache-2.0
      class Campaign < PortaText::Test::Helper::CommandTester
        def test_can_create_sms_campaign_with_text
          test_command 'campaigns', {
            :type => 'sms',
            :name => 'this is the name',
            :description => 'and this is the description',
            :contact_list_ids => [1, 3, 5, 7, 9],
            :from => '12223334444',
            :text => 'Hello world'
          } do |client|
            client
              .sms_campaign
              .name('this is the name')
              .description('and this is the description')
              .to_contact_lists([1, 3, 5, 7, 9])
              .from('12223334444')
              .text('Hello world')
              .post
          end
        end

        def test_can_create_sms_campaign_with_template
          test_command 'campaigns', {
            :type => 'sms',
            :name => 'this is the name',
            :description => 'and this is the description',
            :contact_list_ids => [1, 3, 5, 7, 9],
            :from => '12223334444',
            :template_id => 987,
            :variables => { 'key1' => 'value1' }
          } do |client|
            client
              .sms_campaign
              .name('this is the name')
              .description('and this is the description')
              .to_contact_lists([1, 3, 5, 7, 9])
              .from('12223334444')
              .use_template(987, { 'key1' => 'value1' })
              .post
          end
        end

        def test_can_delete_a_campaign
          test_command 'campaigns/451' do |client|
            client
              .campaigns
              .id(451)
              .delete
          end
        end

        def test_can_get_all_campaigns
          test_command 'campaigns' do |client|
            client
              .campaigns
              .get
          end
        end

        def test_can_get_a_campaign
          test_command 'campaigns/429' do |client|
            client
              .campaigns
              .id(429)
              .get
          end
        end
      end
    end
  end
end
