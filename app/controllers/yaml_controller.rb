class YamlController < ApplicationController
require 'ya2yaml'

  def parse
    @yaml = params[:yaml] || ""
    file_name = Rails.root+'foo.yml'
    file = File.new(file_name, "w+")
    file.write(@yaml)
    if request.post?
      begin
        I18n::Backend::Simple.new.send(:load_translations, file.path)
        # @yaml = YAML.load(@yaml)
        # @yaml = @yaml.ya2yaml(:syck_compatible => true)
      rescue Exception => ex
        @error = ex.message
        if @error =~ /line ([\d]+)/i
          @error_line = $1
        end
      ensure
        File.delete(file_name)
      end
    end
  end

end
