use v6.c;

use GTK::Compat::Types;
use WNCK::Raw::Types;

use WNCK::Raw::Pager;

use GTK::Widget;

class WNCK::Pager is GTK::Widget {
  has WnckPager $!wp;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$pager) {
    given $pager {
      when PagerAncestry {
        my $to-parent;
        $!wp = do {
          when WnckPager {
            $to-parent = cast(GtkWidget, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(WnckPager, $_);
          }
        }
        self.setWidget($to-parent);
      }
      when WNCK::Pager {
      }
      default {
      }
    }
  }

  method WNCK::Raw::Types::WnckPager
  { $!wp }

  method new () {
    self.bless( pager => wnck_pager_new() );
  }

  method wrap_on_scroll is rw is also<wrap-on-scroll> {
    Proxy.new(
      FETCH => sub ($) {
        so wnck_pager_get_wrap_on_scroll($!wp);
      },
      STORE => sub ($, Int() $wrap_on_scroll is copy) {
        my gboolean $wos = resolve-bool($wrap_on_scroll);
        wnck_pager_set_wrap_on_scroll($!wp, $wos);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &wnck_pager_get_type, $n, $t );
  }

  method set_display_mode (Int() $mode) is also<set-display-mode> {
    my guint $m = resolve-int($mode);
    wnck_pager_set_display_mode($!wp, $m);
  }

  method set_n_rows (Int() $n_rows) is also<set-n-rows> {
    my gint $nr = resolve-int($n_rows);
    wnck_pager_set_n_rows($!wp, $nr);
  }

  method set_orientation (Int() $orientation) is also<set-orientation> {
    my guint $o = resolve-uint($orientation);
    wnck_pager_set_orientation($!wp, $o);
  }

  method set_shadow_type (Int() $shadow_type) is also<set-shadow-type> {
    my guint $s = resolve-uint($shadow_type);
    wnck_pager_set_shadow_type($!wp, $st);
  }

  method set_show_all (Int() $show_all_workspaces) is also<set-show-all> {
    my gboolean $saw = resolve-bool($show_all_workspaces);
    wnck_pager_set_show_all($!wp, $saw);
  }

}
