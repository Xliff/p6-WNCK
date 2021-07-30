#!/usr/bin/env raku
use v6.c;

use WNCK::Raw::Types;

use X11::Display;
use X11::Xinerama;
use GLib::Timeout;
use GTK::Application;
use WNCK::Screen;

my ($consoles, $num);

sub open-console {
  start qqx«konsole -p tabtitle={ $num - $consoles + 1 }»;
}

sub MAIN (
  $number       where * ~~ 4..25,
  :$console
) {
  my $sqrt = ($num = $number).sqrt;
  die 'Number of consoles must be a number that is a square and is between 4..25'
    unless $sqrt == $sqrt.Int;

  my $app = GTK::Application.new( title => 'org.genex.wnck.konsole-grid' );

  $consoles = $num;

  $app.activate.tap({
    CATCH { default { .message.say } }

    my $screen = WNCK::Screen.get_default;
    my $d      = X11::Display.OpenDisplay(%*ENV<DISPLAY>);
    my $xin-qs = $d.Xinerama.QueryScreens;

    my @d = (
      my ($x, $y, $w, $h) = <x_org y_org width height>.map({
        $xin-qs[0]."$_"()
      });
    );
    ($w, $h) »/=» $sqrt;

    $screen.window-opened.tap( sub (*@a) {
      CATCH { default { .message.say; .backtrace.concise.say } }
      CONTROL { when CX::Warn { .message.say } }

      my $win = WNCK::Window.new( @a[1] );
      return unless $win;

      my $n   = $win.get-name;
      return unless $n ~~ /^ \d+ ' — Konsole'/;
      say "Hello { $n } - New ($w, $h)";

      # cw: First window position refuses to set!
      $win.set-geometry($x, $y, $w, $h);

      $x += $w;
      if $x >= @d[2] {
        $x = @d[0];
        $y += $h;
      }

      open-console if $consoles-- > 1
    });

    GLib::Timeout.add(3, { open-console; 0 });
  });

  $app.run;
}
