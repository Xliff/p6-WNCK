#!/usr/bin/env perl6
use v6.c;

use Cairo;

use WNCK::Raw::Types;

use GDK::Screen;
use GTK::Application;
use GTK::Frame;
use WNCK::Screen;
use WNCK::Tasklist;

my subset IntOrBool where Int | Bool | Any;

my $app;

sub window_draw (cairo_t $cr) {
  $cr.set_operator(CAIRO_OPERATOR_SOURCE);
  $cr.set_source_rgba(1e0, 1e0, 1e0, 5e-1);
  $cr.fill;
  0;
}

sub window_compisited_changed {
  my $screen = GTK::Compat::Screen.get_default;
  my $composited = $screen.is_composited;
  $app.window.app_paintable = $composited;
}

sub MAIN (
  IntOrBool :$display-all   = False,                       #= Display windows from all workspaces
  IntOrBool :$never-group   = Nil,                         #= Never group windows
  IntOrBool :$always-group  = Nil,                         #= Always group windows
  IntOrBool :$rtl           = False,                       #= Use RTL as default direction
  IntOrBool :$skip-tasklist = False,                       #= Don't show window in tasklist
  IntOrBool :$vertical      = False,                       #= Show in vertical mode
  IntOrBool :$transparent   = False,                       #= Enable transparency
  IntOrBool :$enable-scroll = False,                       #= Enable scrolling
  Int       :$icon-size     = WNCK_DEFAULT_MINI_ICON_SIZE  #= Icon size for tasklist
) {
  $app = GTK::Application.new( title => 'org.genex.wnck.tasklist' );

  $app.activate.tap({
    $app.wait-for-init;

    my $screen = WNCK::Screen.new;
    $screen.force_update;

    $app.window.set_default_size(200, 100);
    $app.window.stick;
    $app.window.resizable = True;

    my $tasklist = WNCK::Tasklist.new;
    $tasklist.set_include_all_workspaces($display-all);
    $tasklist.set_grouping(WNCK_TASKLIST_AUTO_GROUP);
    $tasklist.set_grouping(WNCK_TASKLIST_ALWAYS_GROUP) if $always-group.defined;
    $tasklist.set_grouping(WNCK_TASKLIST_NEVER_GROUP)  if $never-group.defined;
    $tasklist.scroll_enabled = $enable-scroll;
    $tasklist.set_middle_click_close(True);
    $tasklist.set_orientation($vertical ?? GTK_ORIENTATION_VERTICAL !!
                                           GTK_ORIENTATION_HORIZONTAL);
    if $transparent {
      if GDK::Screen.get_rgba_visual($app.window.get_screen) -> $v {
        $app.window.visual = $v;

        $app.window.composited-changed.tap({ window_compisited_changed });
        $app.window.draw.tap(-> *@a { window_draw(@a[1]) });
        window_compisited_changed;
      }

      $tasklist.set_button_relief(GTK_RELIEF_NONE);
    }

    my $frame = GTK::Frame.new;
    $frame.shadow_type = GTK_SHADOW_IN;
    $frame.add($tasklist);
    $app.window.add($frame);
    $app.window.move(0, 0);

    if $skip-tasklist {
      $app.window.skip_taskbar_hint = True;
      $app.window.set_keep_above(True);
    }

    $app.window.show_all;
  });

  $app.run;
}
