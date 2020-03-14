use v6.c;

use Method::Also;

use WNCK::Raw::Types;
use WNCK::Raw::Tasklist;

use GLib::Value;
use GTK::Container;

our subset TasklistAncestry is export of Mu
  where WnckTasklist | ContainerAncestry;

class WNCK::Tasklist is GTK::Container {
  has WnckTasklist $!wt;

  submethod BUILD (:$tasklist) {
    given $tasklist {
      when TasklistAncestry {
        my $to-parent;
        $!wt = do {
          when WnckTasklist {
            $to-parent = cast(GtkContainer, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(WnckTasklist, $_);
          }
        }
        self.setContainer($to-parent);
      }
    }
  }

  method WNCK::Raw::Types::WnckTasklist
    is also<WnckTasklist>
  { $!wt }

  method new {
    my $tasklist = wnck_tasklist_new();

    $tasklist ?? self.bless(:$tasklist) !! WnckTasklist;
  }

  method scroll_enabled is rw is also<scroll-enabled> {
    Proxy.new(
      FETCH => sub ($) {
        so wnck_tasklist_get_scroll_enabled($!wt);
      },
      STORE => sub ($, Int() $scroll_enabled is copy) {
        my gboolean $s = $scroll_enabled.so.Int;

        wnck_tasklist_set_scroll_enabled($!wt, $s);
      }
    );
  }

  # Type: gfloat
  method fade-loop-time is rw is also<fade_loop_time> {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('fade-loop-time', $gv)
        );
        $gv.float;
      },
      STORE => -> $, $val is copy {
        warn 'WNCK::Tasklist.fade-loop-time does not support writing';
      }
    );
  }

  # Type: gint
  method fade-max-loops is rw is also<fade_max_loops> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('fade-max-loops', $gv)
        );
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn 'WNCK::Tasklist.fade-max-loops does not support writing';
      }
    );
  }

  # Type: gfloat
  method fade-opacity is rw is also<fade_opacity> {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('fade-opacity', $gv)
        );
        $gv.float;
      },
      STORE => -> $, $val is copy {
        warn 'WNCK::Tasklist.fade-opacity does not support writing';
      }
    );
  }

  # Type: gint
  method fade-overlay-rect is rw is also<fade_overlay_rect> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('fade-overlay-rect', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        warn 'WNCK::Tasklist.fade-overlay-rect does not support writing';
      }
    );
  }

  method get_size_hint_list (Int() $n_elements) is also<get-size-hint-list> {
    my gint $n = $n_elements;

    wnck_tasklist_get_size_hint_list($!wt, $n);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &wnck_tasklist_get_type, $n, $t );
  }

  method set_button_relief (Int() $relief) is also<set-button-relief> {
    my guint $r = $relief;

    wnck_tasklist_set_button_relief($!wt, $r);
  }

  method set_grouping (Int() $grouping) is also<set-grouping> {
    my guint $g = $grouping;

    wnck_tasklist_set_grouping($!wt, $g);
  }

  method set_grouping_limit (Int() $limit) is also<set-grouping-limit> {
    my gint $l = $limit;

    wnck_tasklist_set_grouping_limit($!wt, $l);
  }

  method set_icon_loader (
    &load_icon_func,
    gpointer $data           = gpointer,
    gpointer $free_data_func = gpointer
  )
    is also<set-icon-loader>
  {
    wnck_tasklist_set_icon_loader(
      $!wt,
      &load_icon_func,
      $data,
      $free_data_func
    );
  }

  method set_include_all_workspaces (Int() $include_all_workspaces)
    is also<set-include-all-workspaces>
  {
    my gboolean $iaw = $include_all_workspaces.so.Int;

    wnck_tasklist_set_include_all_workspaces($!wt, $iaw);
  }

  method set_middle_click_close (Int() $middle_click_close)
    is also<set-middle-click-close>
  {
    my gboolean $m = $middle_click_close.so.Int;

    wnck_tasklist_set_middle_click_close($!wt, $m);
  }

  method set_orientation (Int() $orient) is also<set-orientation> {
    my guint $o = $orient;

    wnck_tasklist_set_orientation($!wt, $o);
  }

  method set_switch_workspace_on_unminimize (
    Int() $switch_workspace_on_unminimize
  )
    is also<set-switch-workspace-on-unminimize>
  {
    my gboolean $swou = $switch_workspace_on_unminimize.so.Int;

    wnck_tasklist_set_switch_workspace_on_unminimize($!wt, $swou);
  }

}
