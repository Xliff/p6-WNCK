use v6.c;

use GTK::Compat::MainLoop;
use GLib::Timeout;
use GDK::Main;

use WNCK::Application;
use WNCK::Screen;
use WNCK::Window;

sub MAIN {
  GDK::Main.init;

  my ($loop, $screen, $to) = ( GTK::Compat::MainLoop.new, WNCK::Screen.get(0) );

  $screen.application-opened.tap(-> *@b {
    CATCH { default { .message.say } }
    .unshade for WNCK::Application.new( @b[1] ).windows;

    # If this signal hasn't been emitted for half a second, assume all
    # applications have been processed, then quit. We only need to do
    # this ONCE.
    $to = GLib::Timeout.add(500, -> *@a { $loop.quit; 0 });
  });

  $loop.run;
  $loop.unref;
}
