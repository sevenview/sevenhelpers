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

    def google_analytics_code(tracking_id)
      output = <<EOF
<-- Google Analytics -->
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
<-- end Google Analytics -->
EOF
      raw(output)
    end
  end
end