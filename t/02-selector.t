#!/usr/bin/env perl6
use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Frame;

use WNCK::Screen;
use WNCK::Selector;

sub MAIN (:$skip-tasklist = False) {
  my $app = GTK::Application.new( title => 'org.genex.wnck.tasklist' );

  $app.activate.tap({
    $app.wait-for-init;

    my $screen = WNCK::Screen.new;
    $screen.force-update;

    $app.window.set_default_size(200, 32);
    $app.window.stick;
    $app.window.title = 'Window Selector';
    $app.window.resizable = True;
    $app.window.move(0, 0);

    my $selector = WNCK::Selector.new;
    my $frame    = GTK::Frame.new;
    $frame.shadow_type = GTK_SHADOW_IN;
    $frame.add($selector);
    $app.window.add($frame);

    if $skip-tasklist {
      $app.window.skip-taskbar-hint = True;
      $app.window.set_keep_above(True);
    }

    $app.window.show_all;
  });

  $app.run;
}
