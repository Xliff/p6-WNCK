use v6.c;

use GLib::MainLoop;
use GLib::Timeout;
use GDK::Main;

use WNCK::Application;
use WNCK::Screen;
use WNCK::Window;

sub MAIN {
  GDK::Main.init;

  my ($loop, $screen, $to) = ( GLib::MainLoop.new, WNCK::Screen.get(0) );

  $screen.application-opened.tap(-> *@b {
    CATCH { default { .message.say } }

    for WNCK::Application.new( @b[1] ).windows {
      .shade unless .name.contains('Konsole');
    }
    # Wait for half a second, then assume all applications have been processed,
    # and quit.
    $to = GLib::Timeout.add(500, -> *@a { $loop.quit; 0 });
  });

  $loop.run;
  $loop.unref;
}
