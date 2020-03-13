use v6.c;

use GLib::Raw::Definitions;
use WNCK::Raw::Definitions;

use GLib::Roles::Pointers;

unit package WNCK::Raw::Structs;

class WnckResourceUsage is repr<CStruct> does GLib::Roles::Pointers is export {
  has gulong  $.total_bytes_estimate is rw;
  has gulong  $.pixmap_bytes         is rw;
  has guint   $.n_pixmaps            is rw;
  has guint   $.n_windows            is rw;
  has guint   $.n_gcs                is rw;
  has guint   $.n_pictures           is rw;
  has guint   $.n_glyphsets          is rw;
  has guint   $.n_fonts              is rw;
  has guint   $.n_colormap_entries   is rw;
  has guint   $.n_passive_grabs      is rw;
  has guint   $.n_cursors            is rw;
  has guint   $.n_other              is rw;
};
