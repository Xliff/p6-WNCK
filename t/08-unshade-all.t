use v6.c;

use GTK::Compat::Timeout;

use GTK::Application;

use WNCK::Application;
use WNCK::Screen;
use WNCK::Window;

sub MAIN {
  my $app = GTK::Application.new;

  $app.activate.tap(-> *@a {
    $app.wait-for-init;
    
    my $screen = WNCK::Screen.get(0);

    $screen.application-opened.tap(-> *@b {
      CATCH { default { .message.say } }
      .unshade for WNCK::Application.new( @b[1] ).windows
    });

    GTK::Compat::Timeout.simple-timeout-in-seconds(1).tap(-> *@a {
      $app.exit;
    });

  });

  $app.run;
}
