use v6.c;

use NativeCall;
use Method::Also;

use WNCK::Raw::Types;

use GTK::Menu;

use GLib::Value;
use WNCK::Window;

our subset ActionMenuAncestry is export of Mu
  where WnckActionMenu | MenuAncestry;

class WNCK::ActionMenu is GTK::Menu {
  has WnckActionMenu $!wam;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$actionmenu) {
    given $actionmenu {
      when ActionMenuAncestry {
        my $to-parent;
        $!wam = do {
          when WnckActionMenu {
            $to-parent = cast(GtkMenu, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(WnckActionMenu, $_);
          }
        }
        self.setMenu($to-parent);
      }

      when WNCK::ActionMenu {
      }

      default {
      }
    }
  }

  multi method new (ActionMenuAncestry $actionmenu) {
    $actionmenu ?? self.bless( :$actionmenu ) !! WnckActionMenu;
  }
  multi method new (WnckWindow() $window) {
    my $actionmenu = wnck_action_menu_new($window);

    $actionmenu ?? self.bless( :$actionmenu ) !! WnckActionMenu;
  }

  # Type: gpointer
  method window (:$raw = False) is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('window', $gv)
        );

        return WnckWindow unless $gv.object;

        my $w = cast(WnckWindow, $gv.object);

        $raw ?? $w !! WNCK::Window.new($w);
      },
      STORE => -> $, $val is copy {
        warn 'Can only set WNCK::ActionMenu.window at construct-time';
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &wnck_action_menu_get_type, $n, $t );
  }

}

sub wnck_action_menu_get_type ()
  returns GType
  is native(wnck)
  is export
{ * }

sub wnck_action_menu_new (WnckWindow $window)
  returns WnckActionMenu
  is native(wnck)
  is export
{ * }
