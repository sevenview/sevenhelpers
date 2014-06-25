module Sevenhelpers
  module ViewHelpers
    def copyright_years(start_year = Time.now.year)
      current_year = Time.now.year
      if start_year > current_year # trap if user sets start year ahead of current year
        output = current_year.to_s
      else
        output = start_year.to_s
        output << "-#{current_year.to_s}" if start_year != current_year
      end
      output
    end

    def google_analytics_code(tracking_id, options = {})
      options.reverse_merge!(show_placeholder: true, environments: %w(production), universal: false)

      if options[:environments].include? Rails.env
        output = "<!-- Google Analytics -->\n"
        output << if options[:universal]
          google_analytics_universal(tracking_id, options[:domain])
        else
          google_analytics_classic(tracking_id)
        end
        output << '<!-- end Google Analytics -->'
      elsif options[:show_placeholder]
        output = "<!-- actual Google Analytics code will render here in #{ options[:environments].map(&:capitalize).to_sentence } -->"
      else
        output = ''
      end
      raw(output)
    end

    def error_messages_for(obj)
      content = ""
      if obj.errors.any?
        content << '<div class="error-messages">'
        content << "<h2>#{pluralize(obj.errors.count, "error")} prohibited this form from being saved:</h2>"
        content << "<ul>"
        obj.errors.full_messages.each do |msg|
          content << "<li>#{msg}</li>"
        end
        content << "</ul>"
        content << "</div>"
      end
      raw(content) if content
    end

    private

    def google_analytics_classic(tracking_id)
      <<-EOD
      <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', '#{tracking_id}']);
        _gaq.push(['_trackPageview']);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
      EOD
    end

    def google_analytics_universal(tracking_id, domain)
      <<-EOD
      <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', '#{tracking_id}', '#{domain}');
        ga('send', 'pageview');
      </script>
      EOD
    end
  end
end
