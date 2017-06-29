(function() {
  var config;

  App.Utils.Auth = {};

  config = {
    facebook: {
      width: 980,
      height: 630
    },
    github: {
      width: 1060,
      height: 500
    },
    google: {
      width: 800,
      height: 450
    },
    hatena: {
      width: 940,
      height: 600
    },
    linkedin: {
      width: 420,
      height: 630
    },
    mixi: {
      width: 980,
      height: 600
    },
    twitter: {
      width: 600,
      height: 600
    }
  };

  App.Utils.Auth.windowOpen = function(linkElementId) {
    var $linkElement, authUrl, checkSubwindowClosed, params, provider, subwindow;
    window.authWaiting || (window.authWaiting = {});
    $linkElement = $('#' + linkElementId);
    provider = $linkElement.data('provider');
    authUrl = $linkElement.data('url');
    checkSubwindowClosed = function() {
      if (window.authWaiting[provider]) {
        if (subwindow.closed) {
          App.Utils.Auth.afterCallback($linkElement, false);
          return window.authWaiting[provider] = false;
        } else {
          return setTimeout(checkSubwindowClosed, 1000);
        }
      }
    };
    App.Utils.Auth.beforeCallback($linkElement);
    params = "width=" + config[provider]['width'] + ",height=" + config[provider]['height'] + ",resizable,scrollbars=yes,status=1";
    subwindow = window.open(authUrl, provider, params);
    window.authWaiting[provider] = true;
    return checkSubwindowClosed();
  };

  App.Utils.Auth.beforeCallback = function($linkElement) {
    $linkElement.text(I18n.t('auth.connecting'));
    return $linkElement.attr('disabled', 'disabled');
  };

  App.Utils.Auth.afterCallback = function($linkElement, success) {
    if (success) {
      $linkElement.text(I18n.t('auth.connected'));
      return $linkElement.attr('disabled', 'disabled');
    } else {
      $linkElement.text(I18n.t('auth.connect'));
      return $linkElement.removeAttr('disabled');
    }
  };

  $(document).on('click', '.social-connect', function() {
    return App.Utils.Auth.windowOpen($(this).attr('id'));
  });

}).call(this);
