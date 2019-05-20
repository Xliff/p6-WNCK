#!/usr/bin/env perl6
use v6.c;

use GTK::Compat::Types;
use GTK::Compat::MainLoop;
use GTK::Compat::Timeout;

use GTK::Application;
use WNCK::Screen;
use WNCK::Utils;

sub MAIN {
  GTK::Application.init;

  my $loop = GTK::Compat::MainLoop.new(GMainContext, False);

  while True {
    my $screen = WNCK::Screen.new;
    say "WNCK will be active for 5 seconds; change the active window to get { ''
         }notifications";
    $screen.active-window-changed.tap(-> *@a {
      CATCH { default { .message.say } }
      say 'ohai';
      with $screen.get_active_window {
        say "active: { .get_name }";
      } else {
        say "no active window";
      }
    });
    GTK::Compat::Timeout.add_seconds(5, -> *@a { $loop.quit; 0 });
    $loop.run;

    say "libwnck is shutting down for 5 seconds; no notification will happen.";
    WNCK::Utils.shutdown;
    GTK::Compat::Timeout.add_seconds(5, -> *@a { $loop.quit; 0 });
    $loop.run;
    say 'libwnck is getting reinitialized...';
  };

}
