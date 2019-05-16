use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GTK::Raw::Types;
use WNCK::Raw::Types;

use GTK::Raw::Utils;

use WNCK::Raw::Tasklist;

use GTK::Container;

our TasklistAncestry is export of Mu
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
    wnck_tasklist_new();
  }

  method scroll_enabled is rw is also<scroll-enabled> {
    Proxy.new(
      FETCH => sub ($) {
        wnck_tasklist_get_scroll_enabled($!wt);
      },
      STORE => sub ($, $scroll_enabled is copy) {
        wnck_tasklist_set_scroll_enabled($!wt, $scroll_enabled);
      }
    );
  }

  # Type: gfloat
  method fade-loop-time is rw is also<fade_loop_time> {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('fade-loop-time', $gv)
        )
        $gv.float;
      },
      STORE => -> $, $val is copy {
        warn 'WNCK::Tasklist.fade-loop-time does not support writing';
      }
    );
  }

  # Type: gint
  method fade-max-loops is rw is also<fade_max_loops> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('fade-max-loops', $gv)
        )
        $gv.int;
      },
      STORE => -> $, $val is copy {
        warn 'WNCK::Tasklist.fade-max-loops does not support writing';
      }
    );
  }

  # Type: gfloat
  method fade-opacity is rw is also<fade_opacity> {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('fade-opacity', $gv)
        )
        $gv.float;
      },
      STORE => -> $, $val is copy {
        warn 'WNCK::Tasklist.fade-opacity does not support writing';
      }
    );
  }

  # Type: gint
  method fade-overlay-rect is rw is also<fade_overlay_rect> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('fade-overlay-rect', $gv)
        )
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        warn 'WNCK::Tasklist.fade-overlay-rect does not support writing';
      }
    );
  }

  method get_size_hint_list (int $n_elements) is also<get-size-hint-list> {
    wnck_tasklist_get_size_hint_list($!wt, $n_elements);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &wnck_tasklist_get_type, $n, $t );
  }

  method set_button_relief (Int() $relief) is also<set-button-relief> {
    my guint $r = resolve-uint($relief);
    wnck_tasklist_set_button_relief($!wt, $r);
  }

  method set_grouping (Int() $grouping) is also<set-grouping> {
    my guint $g = resolve-uint($grouping);
    wnck_tasklist_set_grouping($!wt, $g);
  }

  method set_grouping_limit (Int() $limit) is also<set-grouping-limit> {
    my gint $l = resolve-int($limit);
    wnck_tasklist_set_grouping_limit($!wt, $l);
  }

  method set_icon_loader (
    &load_icon_func,
    Pointer $data           = Pointer,
    Pointer $free_data_func = Pointer
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
    my gboolean $iaw = resolve-bool($include_all_workspaces);
    wnck_tasklist_set_include_all_workspaces($!wt, $iaw);
  }

  method set_middle_click_close (Int() $middle_click_close)
    is also<set-middle-click-close>
  {
    my gboolean $m = resolve-bool($middle_click_close);
    wnck_tasklist_set_middle_click_close($!wt, $m);
  }

  method set_orientation (Int() $orient) is also<set-orientation> {
    my guint $o = resolve-uint($orient);
    wnck_tasklist_set_orientation($!wt, $o);
  }

  method set_switch_workspace_on_unminimize (
    Int() $switch_workspace_on_unminimize
  )
    is also<set-switch-workspace-on-unminimize>
  {
    my gboolean $swou = resolve-bool($switch_workspace_on_unminimize);
    wnck_tasklist_set_switch_workspace_on_unminimize($!wt, $swou);
  }

}
