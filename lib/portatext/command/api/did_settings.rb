module PortaText
  module Command
    module Api
      # The dids/:did endpoint.
      # https://github.com/PortaText/docs/wiki/REST-API#api_did_settings
      #
      # Author::    Marcelo Gornstein (mailto:marcelog@portatext.com)
      # Copyright:: Copyright (c) 2015 PortaText
      # License::   Apache-2.0
      class DidSettings < Base
        def for_number(number)
          set :id, number
        end

        def disable_cnam
          set :cnam_enabled, false
        end

        def enable_cnam
          set :cnam_enabled, true
        end

        def dont_autorespond
          set :autoresponder_enabled, false
        end

        def autorespond_with(text)
          set :autoresponder_text, text
          set :autoresponder_enabled, true
        end

        def endpoint(_method)
          id = @args[:id]
          @args.delete :id
          return "dids/#{id}" unless id.nil?
          'dids'
        end
      end
    end
  end
end
