use v6.c;

use GTK::Compat::Types;
use GTK::Raw::Types;
use WNCK::Raw::Types;

use GTK::Compat::Threads;
use GTK::Compat::Value;

use GTK::Application;
use GTK::Get;
use GTK::ListStore;
use GTK::ScrolledWindow;
use GTK::TreeView;

use GTK::CellRendererPixbuf;
use GTK::CellRendererText;
use GTK::CellRendererToggle;

use WNCK::Screen;

use GTK::Roles::TreeModel;

my %globals;

sub MAIN (
  Int :$icon-size       #= Icon size for tasklist
) {
  my $app = GTK::Application.new( title => 'org.genex.wnck' );

  $app.activate.tap({
    CATCH { default { .message.say } }
    $app.wait-for-init;

    %globals<screen> = WNCK::Screen.get(0);

    %globals<screen>."$_"().tap(-> *@a {
      CATCH { default { .message.say } }
      ::( "\&on-$_")( |@a );
     })
    for <
      active-window-changed
      active-workspace-changed
      window-stacking-changed
      window-opened
      window-closed
      workspace-created
      workspace-destroyed
      application-opened
      application-closed
      showing-desktop-changed
    >;

    $app.window.title = 'Window List';
    create_tree_model;
    create_tree_view;
    %globals<tree-view>.model = %globals<tree-model>;

    my $sw = GTK::ScrolledWindow.new;
    $sw.set-policy(GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
    $sw.add(%globals<tree-view>);
    $app.window.add($sw);
    $app.window.set_default_size(650, 550);
    $app.window.show_all;
  });

  $app.run;
}

sub on-active-window-changed ($s, $p, $d) {
  CATCH { default { .message.say } }
  say 'Active window changed';
  update_window($_) with %globals<screen>.get_active_window;
}

sub on-active-workspace-changed ($s, $p, $d) {
  say 'Active workspace changed';
}

sub on-window-stacking-changed ($s, $d) {
  say 'Stacking changed';
}

sub on-window-closed ($s, $w, $d) {
  my $win = WNCK::Window.new($w);
  say "Window '{ $win.get-name }' closed";
}

sub on-workspace-created ($s, $ws, $d) {
  say 'Workspace created';
}

sub on-workspace-destroyed ($s, $ws, $d) {
  say 'Workspace destoryed';
}

sub on-application-opened ($s, $app, $d) {
  say 'Application opened';
  queue_refill_model;
}

sub on-application-closed ($s, $app, $d) {
  say 'Application closed';
  queue_refill_model;
}

sub on-showing-desktop-changed ($s, $d) {
  say "Showing desktop now = { %globals<screen>.get_showing_desktop }";
}

sub on-window-opened ($s, $w, $d) {
  CATCH { default { .message.say } }

  my $win = WNCK::Window.new($w);
  my $sid = $win.get-session-id;
  my $r   = $win.get-role;
  say qq:to/WO/.chomp;
Window '{ $win.get-name }' opened (pid = { $win.get-pid }, { ''
}session_id = { $sid ?? $sid !! 'none' }, { ''
}role = { $r ?? $r !! 'none' })
WO

  $win."$_"().tap(-> *@b { ::( "\&window-$_" )( |@b ); })
    for <
      name-changed
      state-changed
      workspace-changed
      icon-changed
      geometry-changed
      class-changed
      role-changed
    >;

  queue_refill_model;
}

sub window-name-changed ($w, $d) {
  say "Name changed on window '{ $w.get-name }'";
  update_window($w);
}

sub window-state-changed ($w, $c, $n, $d) {
  CATCH { default { .message.say } }

  say "State changed on window '{ $w.get_name }'";

  sub state ($c, $v) {
    say "$c state is:";
    say "  - minimized"     if $v +& WNCK_WINDOW_STATE_MINIMIZED;
    say "  - maximized V"   if $v +& WNCK_WINDOW_STATE_MAXIMIZED_VERTICALLY;
    say "  - maximized H"   if $v +& WNCK_WINDOW_STATE_MAXIMIZED_HORIZONTALLY;
    say "  - shaded"        if $v +& WNCK_WINDOW_STATE_SHADED;
    say "  - skip pager"    if $v +& WNCK_WINDOW_STATE_SKIP_PAGER;
    say "  - skip tasklist" if $v +& WNCK_WINDOW_STATE_SKIP_TASKLIST;
    say "  - sticky"        if $v +& WNCK_WINDOW_STATE_STICKY;
    say "  - fullscreen"    if $v +& WNCK_WINDOW_STATE_FULLSCREEN;
  }

  state('Old', $c);
  state('New', $n);

  update_window($w);
}

sub window-workspace-changed ($w, $d) {
  my $space = $w.get_workspace;

  if $space {
    say "Workspace changerd on window '{ $w.get-name }' to { $w.get_number }";
  } else {
    say "Window '{ $w.get-name } is now pinned to ALL workspaces";
  }

  update_window($w);
}

sub window-icon-changed ($w, $d) {
  say "Icon changed on window '{ $w.get-name }'";
  update_window($w);
}

sub window-geometry-changed ($w, $d) {
  my ($x, $y, $width, $height) = $w.get-geometry;
  say "Geometry changed on window '{ $w.get-name }': {$x},{$y}  {$width}x{$height}";
}

sub window-class-changed ($w, $d) {
  my ($n, $gn, $in) =
    ($w.get-namne, $w.get-class-group-name, $w.get-class-instance-name);
  say "Class changed on window '{ $n }': { $gn }, { $in }";
}

sub window-role-changed ($w, $d) {
  my ($n, $r) = ($w.get-name, $w.get-role);
  say "Role changed on window '{ $n }': { $r }";
}

sub create_tree_model {
  %globals<tree-model> = GTK::ListStore.new( G_TYPE_OBJECT );
}

sub refill_tree_model {
  CATCH { default { say "RTM: { .message }" } }

  %globals<tree-model>.clear;
  for %globals<screen>.get_windows -> $w {
    my $i = %globals<tree-model>.append;
    %globals<tree-model>.set_value(
      $i, 0, gv_obj($w.WnckWindow)
    );
    if $w.is_active {
      my $sel = %globals<tree-view>.get-selection;
      $sel.unselect-all;
      $sel.select-iter($i);
    }
  }

  %globals<tree-view>.columns-autosize;
}

sub update_window ($w) {
  return if %globals<refill-idle>;

  my @windows = %globals<screen>.get-windows;
  my $i = @windows.keys.grep({
    +$w.defined && @windows[$_].WnckWindow.p == +$w.WnckWindow.p
  })[0];

  return unless $i.defined;

  my $iter = GtkTreeIter.new;
  if %globals<tree-model>.iter_nth_child($iter, GtkTreeIter, $i) {
    %globals<tree-model>.set_value( $iter, 0, gv_obj($w.WnckWindow) );
    if $w.is_active {
      my $sel = %globals<tree-view>.get_selection;
      $sel.unselect_all;
      $sel.select_iter($iter);
    }
  } else {
    warn "Tree model has no row { $i }";
  }
}

sub get_window ($iter) {
  my $gv = %globals<tree-model>.get_value($iter, 0);
  my $window = WNCK::Window.new( cast(WnckWindow, $gv.object) );
  $window.unref if $window.defined;
  $window;
}

sub icon_set_func ($tc, $c, $m, $i, $d) {
  CATCH { default { .message.say } }

  my $w = get_window($i);
  return unless $w.defined;

  my $cr = GTK::CellRendererPixbuf.new($c);
  $cr.pixbuf = $w.get-mini-icon;
}

sub title_set_func ($tc, $c, $m, $i, $d) {
  CATCH { default { .message.say } }

  my $w = get_window($i);
  return unless $w.defined;

  my $cr = GTK::CellRendererText.new($c);
  $cr.text = $w.get-name;
}

sub workspace_set_func ($tc, $c, $m, $i, $d) {
  CATCH { default { .message.say } }

  my $w = get_window($i);
  return unless $w.defined;

  my $space = $w.get_workspace;
  my $name = do given $space {
    when .defined        { $space.get_number }
    when $w.is_pinned.so { 'all'  }
    default              { 'none' }
  };

  my $cr = GTK::CellRendererText.new($c);
  $cr.text = $name;
}

sub pid_set_func ($tc, $c, $m, $i, $d) {
  CATCH { default { .message.say } }

  my $w = get_window($i);
  return unless $w.defined;

  my $pid = $w.get_pid;
  my $name = do given $pid {
    when $_ > 0 { $pid }
    default     { 'not set' }
  };

  my $cr = GTK::CellRendererText.new($c);
  $cr.text = $name;
}

sub shaded_set_func ($tc, $c, $m, $i, $d) {
  CATCH { default { .message.say } }

  my $w = get_window($i);
  return unless $w.defined;

  my $cr = GTK::CellRendererToggle.new($c);
  $cr.active = $w.is_shaded;
}

sub shaded_toggled_callback ($c, $p, $d) {
  my $i = %globals<tree-model>.get_iter( GTK::TreePath.new_from_string($p) );
  my $w = get_window($i);

  $w.is_shaded ?? $w.unshade !! $w.shade;
}

sub minimized_set_func ($tv, $c, $m, $i, $d) {
  CATCH { default { .message.say } }

  my $w = get_window($i);
  return unless $w.defined;

  GTK::CellRendererToggle.new($c).active = $w.is_minimized;
}

sub minimized_toggled_callback ($c, $p, $d) {
  my $i = %globals<tree-model>.get_iter( GTK::TreePath.new_from_string($p) );
  my $w = get_window($i);
  $w.is_minimized ?? $w.unminimized !! $w.minimize;
}

sub maximized_set_func ($tv, $c, $m, $i, $d) {
  CATCH { default { .message.say } }

  my $w = get_window($i);
  return unless $w.defined;

  GTK::CellRendererToggle.new($c).active = $w.is_maximized;
}

sub maximized_toggled_callback ($c, $p, $d) {
  my $i = %globals<tree-model>.get_iter( GTK::TreePath.new_from_string($p) );
  my $w = get_window($i);
  $w.is_maximized ?? $w.unmaximize !! $w.minimize;
}

sub session_id_set_func ($tv, $c, $m, $i, $d) {
  CATCH { default { .message.say } }

  my $w = get_window($i);
  return unless $w.defined;

  my $id = $w.get_session_id_utf8;
  GTK::CellRendererText.new($c).text = $id ?? $id !! 'not session managed';
}

sub selection_func ($s, $m, $p, $cs, $d) {
  CATCH { default { .message.say } }

  my $i = %globals<tree-model>.get_iter($p);
  my $w = get_window($i);
  return unless $w.defined;

  return $w.is_active.not.Int if $cs.so;
  return 1 if $w.is_active;
  $w.activate;
  0;
}

sub create_tree_view {
  %globals<tree-view> = GTK::TreeView.new;

  my $col = GTK::TreeViewColumn.new;
  $col.title = 'Window';

  my $pbc = GTK::CellRendererPixbuf.new;
  $pbc.xpad = 2;
  $col.pack_start($pbc);
  $col.set_cell_data_func($pbc, &icon_set_func);

  my $tc = GTK::CellRendererText.new;
  $col.pack_start($tc, True);
  $col.set_cell_data_func($tc, &title_set_func);
  %globals<tree-view>.append_column($col);

  for (
    [ 'Workspace',  GTK::CellRendererText.new,   &workspace_set_func ,  Nil ],
    [ 'PID',        GTK::CellRendererText.new,   &pid_set_func       ,  Nil ],
    [ 'Shaded',     GTK::CellRendererToggle.new, &shaded_set_func    ,  &shaded_toggled_callback    ],
    [ 'Minimized',  GTK::CellRendererToggle.new, &minimized_set_func ,  &minimized_toggled_callback ],
    [ 'Maximized',  GTK::CellRendererToggle.new, &maximized_set_func ,  &maximized_toggled_callback ],
    [ 'Session ID', GTK::CellRendererText.new,   &session_id_set_func,  Nil ]
  ) {
    %globals<tree-view>.append_column_with_data_func( |$_[^3] );
    .[1].toggled.tap(-> *@a { .[3]( |@a ) }) if .[3].defined;
  }

  my $sel = %globals<tree-view>.get-selection;
  $sel.mode = GTK_SELECTION_MULTIPLE;
  $sel.set_select_function(&selection_func);
}

sub do_refill_model {
  CATCH { default { .message.say } }
  %globals<refill-idle> = 0;
  refill_tree_model;
  G_SOURCE_REMOVE.Int;
}

sub queue_refill_model {
  CATCH { default { .message.say } }
  return if %globals<refill-idle>;
  %globals<tree-model>.clear;
  %globals<refill-idle> = GTK::Compat::Threads.add_idle(
    -> $ --> guint32 { do_refill_model }
  );
}
