use v6.c;

use NativeCall;

use GTK::Raw::Types;
use WNCK::Raw::Types;

use GTK::Application;

use WNCK::Pager;
use WNCK::Screen;

sub setup_pager_window ($win, $o, $sa, $pm, $r, $w) {
  $win.stick;
  $win.title = 'Pager';
  $win.move(0, 0);

  my $pager = WNCK::Pager.new;
  $pager.set_show_all($sa);
  $pager.set_display_mode($pm);
  $pager.set_orientation($o);
  $pager.set_n_rows($r);
  $pager.set_shadow_type(GTK_SHADOW_IN);
  $pager.wrap_on_scroll = $w;

  $win.add($pager);
  $win.show_all;
}

my subset IntOrBool where Int | Bool;

sub MAIN (
  #:$only-current,
  Int       :$rows                 = 1,
  IntOrBool :$rtl                  = False,
  IntOrBool :$show-all             = False,
  IntOrBool :$show-name            = False,
  IntOrBool :$vertical-orientation = False,
  IntOrBool :$wrap-on-scroll       = False
) {
  my $app = GTK::Application.new( title => 'org.genex.wnck.pager' );

  $app.activate.tap({
    my $screen = WNCK::Screen.get_default;
    $screen.force_update;

    GTK::Widget.set_default_direction(GTK_TEXT_DIR_RTL);
    my $o = $vertical-orientation.so ??
      GTK_ORIENTATION_VERTICAL !! GTK_ORIENTATION_HORIZONTAL;
    my $sn = $show-name.so ??
      WNCK_PAGER_DISPLAY_NAME !! WNCK_PAGER_DISPLAY_CONTENT;
    setup_pager_window(
      $app.window, $o, $show-all.so, $sn, $rows, $wrap-on-scroll.so
    );
  });

  $app.run;
}
