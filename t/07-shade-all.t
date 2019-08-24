use v6.c;

use GTK::Compat::MainLoop;
use GTK::Compat::Timeout;
use GDK::Main;

use WNCK::Application;
use WNCK::Screen;
use WNCK::Window;

sub MAIN {
  GDK::Main.init;

  my ($loop, $screen, $to) = ( GTK::Compat::MainLoop.new, WNCK::Screen.get(0) );

  $screen.application-opened.tap(-> *@b {
    CATCH { default { .message.say } }

    GTK::Compat::Timeout.cancel($to) if $to.defined;
    for WNCK::Application.new( @b[1] ).windows {
      .shade unless .name.contains('Konsole');
    }
    # If this signal hasn't been emitted for half a second, assume all
    # applications have been processed, then quit. We only need to do
    # this ONCE.
    $to = GTK::Compat::Timeout.add(500, -> *@a { $loop.quit; 0 });
  });

  $loop.run;
  $loop.unref;
}
