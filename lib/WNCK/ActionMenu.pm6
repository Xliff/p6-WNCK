use v6.c;

use NativeCall;
use Method::Also;

use GTK::Compat::Types;
use GTK::Raw::Types;
use WNCK::Raw::Types;

use GTK::Menu;

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
    self.bless( :$actionmenu );
  }
  multi method new (WnckWindow() $window) {
    self.bless( actionmenu => wnck_action_menu_new($window) );
  }

  # Type: gpointer
  method window is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('window', $gv)
        );
        WNCK::Window.new( cast(WnckWindow, $gv.object) );
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
