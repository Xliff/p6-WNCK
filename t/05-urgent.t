#!/usr/bin/env perl6
use v6.c;

use WNCK::Raw::Types;

use GLib::Timeout;
use GLib::Source;
use GTK::Application;
use GTK::Label;

sub set-urgent ($w, $u) {
  my $l = GTK::Label.new( $w.get_child );
  $w.urgency_hint = $u;
  $w.title = $u ?? 'Test Window - Urgent' !! 'Test Window';
  $l.text = "I am { (not $u) ?? 'not ' !! '' }urgent";
}

sub make-urgent ($w) {
  set-urgent($w, True);
  $w.clear_data('wnck-timeout');
  G_SOURCE_REMOVE;
}

my $set = False;

sub MAIN {
  my $app = GTK::Application.new( title => 'org.genex.wnck.urgency' );

  $app.activate.tap({
    $app.wait-for-init;

    my $label = GTK::Label.new;
    $app.window.add($label);
    $app.window.set_default_size(300, 200);
    $app.window.set_keep_above(True);
    $app.window.show_all;

    $app.window.focus-in-event.tap(-> *@a --> gboolean {
      CATCH { default { .message.say } }
      set-urgent($app.window, False);
      if $set {
        my $id = $app.window.prop_get_uint('wnck-timeout');
        GLib::Source.remove($id) if $id.defined;
      }
      @a[*-1].r = 0;
    });

    $app.window.focus-out-event.tap(-> *@a --> gboolean {
      CATCH { default { .message.say } }

      # Not a signal handler, so no .r!
      my $id = GLib::Timeout.add_seconds(3, -> *@b --> gboolean {
        CATCH { default { .message.say } }
        make-urgent($app.window);
      });

      $app.window.prop_set_uint('wnck-timeout', $id);
      @a[* - 1].r = 0;
    });

    set-urgent($app.window, False);
  });

  $app.run;
}
