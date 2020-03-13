use v6.c;

use GLib::Roles::Pointers;

unit package WNCK::Raw::Definitions;

constant wnck is export = 'wnck-3',v0;

class WnckActionMenu        is repr<CPointer> does GLib::Roles::Pointers is export { }
class WnckApplication       is repr<CPointer> does GLib::Roles::Pointers is export { }
class WnckClassGroup        is repr<CPointer> does GLib::Roles::Pointers is export { }
class WnckPager             is repr<CPointer> does GLib::Roles::Pointers is export { }
class WnckScreen            is repr<CPointer> does GLib::Roles::Pointers is export { }
class WnckSelector          is repr<CPointer> does GLib::Roles::Pointers is export { }
class WnckTasklist          is repr<CPointer> does GLib::Roles::Pointers is export { }
class WnckWindow            is repr<CPointer> does GLib::Roles::Pointers is export { }
class WnckWorkspace         is repr<CPointer> does GLib::Roles::Pointers is export { }
