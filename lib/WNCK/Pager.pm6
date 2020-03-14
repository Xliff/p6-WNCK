use v6.c;

use Method::Also;

use WNCK::Raw::Types;
use WNCK::Raw::Pager;

use GTK::Widget;

our subset WnckPagerAncestry is export of Mu
  where WnckPager | WidgetAncestry;

class WNCK::Pager is GTK::Widget {
  has WnckPager $!wp;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$pager) {
    given $pager {
      when WnckPagerAncestry {
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
    is also<WnckPager>
  { $!wp }

  multi method new (WnckPagerAncestry $pager) {
    $pager ?? self.bless(:$pager) !! WnckPager;
  }
  multi method new {
    my $pager = wnck_pager_new();

    $pager ?? self.bless(:$pager) !! WnckPager;
  }

  method wrap_on_scroll is rw is also<wrap-on-scroll> {
    Proxy.new(
      FETCH => sub ($) {
        so wnck_pager_get_wrap_on_scroll($!wp);
      },
      STORE => sub ($, Int() $wrap_on_scroll is copy) {
        my gboolean $wos = $wrap_on_scroll.so.Int;

        wnck_pager_set_wrap_on_scroll($!wp, $wos);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &wnck_pager_get_type, $n, $t );
  }

  method set_display_mode (Int() $mode) is also<set-display-mode> {
    my guint $m = $mode;

    wnck_pager_set_display_mode($!wp, $m);
  }

  method set_n_rows (Int() $n_rows) is also<set-n-rows> {
    my gint $nr = $n_rows;

    wnck_pager_set_n_rows($!wp, $nr);
  }

  method set_orientation (Int() $orientation) is also<set-orientation> {
    my guint $o = $orientation;

    wnck_pager_set_orientation($!wp, $o);
  }

  method set_shadow_type (Int() $shadow_type) is also<set-shadow-type> {
    my guint $st = $shadow_type;

    wnck_pager_set_shadow_type($!wp, $st);
  }

  method set_show_all (Int() $show_all_workspaces) is also<set-show-all> {
    my gboolean $saw = $show_all_workspaces.so.Int;

    wnck_pager_set_show_all($!wp, $saw);
  }

}
