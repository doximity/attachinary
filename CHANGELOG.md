= Version 2.0.0
  * Renamed fork to `attachinary-dox`
  * Remove support for Mongoid. Now only supports active_record.
  * Remove $.attachinary.Templating - use another templating system or just use javascript.
    See: https://github.com/doximity/attachinary/pull/66/files

= Version 1.3.0
  * Added support for Rails 4 (thanks @rochers)
  * Use resource type when building cloudinary urls
  * Make deletion of remote resources configurable
  * Add some optional convenience configurations to attachinary.js

= Version 1.2.7 (wip)
  * Implemented raw file type handling (roomthirteen)

= Version 1.2.6
  * Added "attachinary:fileadded" and "attachinary:fileremoved" js events

= Version 1.2.5
  * BUG FIX: Default jQuery plugin options mutation

= Version 1.2.4
  * Ability to specify custom dropzone via config (drewmca)
  * BUG FIX: Bad browsers (IE) can put '[null]' into the attachinary hash (Yan Pritzker)
  * BUG FIX: Ensuring tags are unique (Yan Pritzker)

= Version 1.2.3
  * Fixed bug with multiple submit buttons in one form (Benjamin Seibert)
  * IE content-type fix (Yan Pritzker)

= Version 1.2.2
  * Ability to cleanup unused files:
    files are automatically tagged with `attachinary_tmp` during upload, and
    untagged when saved in local database.

= Version 1.2.1
  * bugfix: already uploaded image gets deleted from cloudinary when updating model [#29]

= Version 1.2.0
  * Drag and drop support (on supported browsers)
  * Selecting multiple files (on supported browsers)
  * Upload progress indicator (prepended on submit button)
  * Rake task for fetching assets (`rake attachinary:fetch_fileupload`)
  * Ability to assing image urls (e.g. `user.avatar_url = 'http://..'`)
  * Ability to assign IO objects (e.g. `user.avatar = File.open(...)`)
  * No-JS support

= Version 1.1.0
  * BUG FIX: disabling submit key (thanks @drewmca)
  * BUG FIX: models attachments are now removed from cloudinary
    after model is destoyed [mongoid]
  * ability to use form builder (`f.attachinary_file_field :avatar`)
  * BUG FIX: proper field names and ids are generated [simple_form]

= Version 1.0.1
  * bug fix release

= Version 1.0.0
  * Support for Mongoid added. You need to specify which ORM you want
    to use by explicitly requiring it.
  * No backward compatibility.
  * Changed database schema (from N-N to 1-N). Assoc preloading made easier.

= Version 0.0.8
  * no explicit require of cloudinary assets

= Version 0.0.7
  * BUG FIX: removing single attachment

= Version 0.0.6
  * attachment lazy loading
  * removed copies of cloudinary javascript files
