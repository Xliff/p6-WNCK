#!/usr/bin/env perl6
use v6.c;

use GTK::Compat::Types;
use GTK::Raw::Types;
use WNCK::Raw::Types;

use GTK::Compat::Timeout;
use GTK::Compat::Source;

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
  0;
}

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
      my $id = $app.window.get_data_uint('wnck-timeout');
      GTK::Compat::Source.remove($id) if $id.defined;
      @a[*-1].r = 0;
    });

    $app.window.focus-out-event.tap(-> *@a --> gboolean {
      CATCH { default { .message.say } }
      my $id = GTK::Compat::Timeout.add_seconds(3, -> *@a --> gboolean {
        CATCH { default { .message.say } }
        make-urgent($app.window)
      });
      $app.window.set_data_uint('wnck-timeout', $id);
      @a[*-1].r = 0;
    });

    set-urgent($app.window, False);
  });

  $app.run;
}
