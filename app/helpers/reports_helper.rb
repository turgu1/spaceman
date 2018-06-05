module ReportsHelper

  def cache_key_for_reports
    count          = Report.count
    max_updated_at = Report.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "reports/all-#{count}-#{max_updated_at}"
  end

  def report_label(report, group)
    group.blank? ? '' : '&nbsp;&nbsp;&nbsp;' +
    "<i class='#{report.icon.blank? ? 'fa fa-print' : h(report.the_icon)}'></i>&nbsp;" +
    h(report.name) +
    (report.enabled? ? '' : " (#{t('cmn.disabled')})")
  end

  def icon_list
    %w[
      home building sitemap user group print gear gears truck archive bug square-o
      glass music search envelope-o heart star star-o film th-large th th-list check
      times search-plus search-minus power-off signal cog trash-o file-o clock-o road download
      arrow-circle-o-down arrow-circle-o-up inbox play-circle-o rotate-right repeat refresh list-alt
      lock flag headphones volume-off volume-down volume-up qrcode barcode tag tags book bookmark
      camera font bold italic text-height text-width align-left align-center align-right align-justify
      list dedent outdent indent video-camera image pencil map-marker adjust tint edit
      share-square-o check-square-o arrows step-backward fast-backward backward play
      pause stop forward fast-forward step-forward eject chevron-left chevron-right plus-circle
      minus-circle times-circle check-circle question-circle info-circle crosshairs times-circle-o
      check-circle-o ban arrow-left arrow-right arrow-up arrow-down mail-forward share expand compress
      plus minus asterisk exclamation-circle gift leaf fire eye eye-slash warning
      plane calendar random comment magnet chevron-up chevron-down retweet shopping-cart folder
      folder-open arrows-v arrows-h bar-chart twitter-square facebook-square camera-retro
      key cogs comments thumbs-o-up thumbs-o-down star-half heart-o sign-out linkedin-square
      thumb-tack external-link sign-in trophy github-square upload lemon-o phone bookmark-o
      phone-square twitter facebook github unlock credit-card rss hdd-o bullhorn bell
      certificate hand-o-right hand-o-left hand-o-up hand-o-down arrow-circle-left arrow-circle-right
      arrow-circle-up arrow-circle-down globe wrench tasks filter briefcase arrows-alt users
      link cloud flask cut copy paperclip save square navicon
      list-ul list-ol strikethrough underline table magic pinterest pinterest-square
      google-plus-square google-plus money caret-down caret-up caret-left caret-right columns unsorted
      sort sort-down sort-up envelope linkedin undo legal dashboard
      comment-o comments-o flash umbrella clipboard lightbulb-o exchange
      cloud-download cloud-upload user-md stethoscope suitcase bell-o coffee cutlery file-text-o
      building-o hospital-o ambulance medkit fighter-jet beer h-square plus-square angle-double-left
      angle-double-right angle-double-up angle-double-down angle-left angle-right angle-up angle-down
      desktop laptop tablet mobile-phone circle-o quote-left quote-right spinner circle
      reply github-alt folder-o folder-open-o smile-o frown-o meh-o gamepad keyboard-o flag-o
      flag-checkered terminal code reply-all star-half-empty
      location-arrow crop code-fork unlink question info exclamation superscript subscript
      eraser puzzle-piece microphone microphone-slash shield calendar-o fire-extinguisher rocket maxcdn
      chevron-circle-left chevron-circle-right chevron-circle-up chevron-circle-down html5 css3 anchor
      unlock-alt bullseye ellipsis-h ellipsis-v rss-square play-circle ticket minus-square minus-square-o
      level-up level-down check-square pencil-square external-link-square share-square compass toggle-down
      toggle-up toggle-right euro gbp dollar rupee yen rouble won bitcoin file file-text
      sort-alpha-asc sort-alpha-desc sort-amount-asc sort-amount-desc sort-numeric-asc sort-numeric-desc
      thumbs-up thumbs-down youtube-square youtube xing xing-square youtube-play dropbox stack-overflow
      instagram flickr adn bitbucket bitbucket-square tumblr tumblr-square long-arrow-down long-arrow-up
      long-arrow-left long-arrow-right apple windows android linux dribbble skype foursquare trello female
      male gittip gratipay sun-o moon-o vk weibo renren pagelines stack-exchange
      arrow-circle-o-right arrow-circle-o-left toggle-left caret-square-o-left dot-circle-o wheelchair
      vimeo-square turkish-lira try plus-square-o space-shuttle slack envelope-square wordpress openid
      bank graduation-cap yahoo google reddit reddit-square
      stumbleupon-circle stumbleupon delicious digg pied-piper-pp pied-piper-alt drupal joomla language
      fax child paw spoon cube cubes behance behance-square steam steam-square recycle
      car cab tree spotify deviantart soundcloud database file-pdf-o file-word-o
      file-excel-o file-powerpoint-o file-image-o file-archive-o
      file-sound-o file-video-o file-code-o vine codepen jsfiddle life-saver circle-o-notch rebel empire git-square
      git yc-square tencent-weibo qq wechat send
      send-o history circle-thin header paragraph sliders share-alt share-alt-square bomb
      soccer-ball-o futbol-o tty binoculars plug slideshare twitch yelp newspaper-o wifi calculator
      paypal google-wallet cc-visa cc-mastercard cc-discover cc-amex cc-paypal cc-stripe bell-slash
      bell-slash-o trash copyright at eyedropper paint-brush birthday-cake area-chart pie-chart
      line-chart lastfm lastfm-square toggle-off toggle-on bicycle bus ioxhost angellist cc shekel
      sheqel meanpath buysellads connectdevelop dashcube forumbee leanpub sellsy shirtsinbulk
      simplybuilt skyatlas cart-plus cart-arrow-down diamond ship user-secret motorcycle street-view
      heartbeat venus mars mercury intersex transgender transgender-alt venus-double mars-double
      venus-mars mars-stroke mars-stroke-v mars-stroke-h neuter genderless facebook-official pinterest-p
      whatsapp server user-plus user-times hotel viacoin train subway medium y-combinator
      optin-monster opencart expeditedssl battery-4 battery battery-full battery-3
      battery-three-quarters battery-2 battery-half battery-1 battery-quarter battery-0 battery-empty
      mouse-pointer i-cursor object-group object-ungroup sticky-note sticky-note-o cc-jcb cc-diners-club
      clone balance-scale hourglass-o hourglass-1 hourglass-2 hourglass-3
      hourglass hand-grab-o hand-stop-o hand-scissors-o
      hand-lizard-o hand-spock-o hand-pointer-o hand-peace-o trademark registered creative-commons gg
      gg-circle tripadvisor odnoklassniki odnoklassniki-square get-pocket wikipedia-w safari chrome
      firefox opera internet-explorer tv television contao 500px amazon calendar-plus-o
      calendar-minus-o calendar-times-o calendar-check-o industry map-pin map-signs map-o map commenting
      commenting-o houzz vimeo black-tie fonticons reddit-alien edge credit-card-alt codiepie modx
      fort-awesome usb product-hunt mixcloud scribd pause-circle pause-circle-o stop-circle
      stop-circle-o shopping-bag shopping-basket hashtag bluetooth bluetooth-b percent gitlab wpbeginner
      wpforms envira universal-access wheelchair-alt question-circle-o blind audio-description
      volume-control-phone braille assistive-listening-systems asl-interpreting deafness glide glide-g
      sign-language low-vision viadeo viadeo-square snapchat snapchat-ghost snapchat-square pied-piper
      first-order yoast themeisle google-plus-circle font-awesome handshake-o
      envelope-open envelope-open-o linode address-book address-book-o address-card
      address-card-o user-circle user-circle-o user-o id-badge id-card
      id-card-o quora free-code-camp telegram thermometer-4 thermometer-3 thermometer-2 thermometer-1
      thermometer-0 shower bathtub podcast window-maximize window-minimize
      window-restore window-close window-close-o bandcamp grav etsy
      imdb ravelry eercast microchip snowflake-o superpowers wpexplorer meetup
   ].map { |i|
      fa_icon "#{i} 2x", title: i, name:i
    }
  end

end
