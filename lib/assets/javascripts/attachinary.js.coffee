(($) ->
  $.attachinary =
    index: 0
    config:
      disableWith: 'Uploading...'
      indicateProgress: true
      invalidFormatMessage: 'Invalid file format'
      unknownErrorMessage: 'Error uploading file'
      render: (files) ->
        str = "<ul>"
        files.forEach (file) ->
          str += "<li>"
          if file.resource_type == "raw"
            str += '<div class="raw-file"></div>'
          else if file.format == "mp3"
            src = $.cloudinary.url(file.public_id, { "version": file.version, "resource_type": 'video', "format": 'mp3'})
            str += '<audio src="' + src + '" controls />'
          else
            src = $.cloudinary.url(file.public_id, { "version": file.version, "format": 'jpg', "crop": 'fill', "width": 75, "height": 75 })
            str += '<img src="'+ src + '" alt="" width="75" height="75" />'
          str += '<a href="#" data-remove="' + file.public_id + '">Remove</a>'
          str += "</li>"
        str += "</ul>"
        return str


  $.fn.attachinary = (options) ->
    settings = $.extend {}, $.attachinary.config, options

    this.each ->
      $this = $(this)

      if !$this.data('attachinary-bond')
        $this.data 'attachinary-bond', new $.attachinary.Attachinary($this, settings)



  class $.attachinary.Attachinary
    constructor: (@$input, @config) ->
      @options = @$input.data('attachinary')
      @files = @options.files

      @$form = @$input.closest('form')
      @$submit = @$form.find(@options.submit_selector ? 'input[type=submit]')
      @$wrapper = @$input.closest(@options.wrapper_container_selector) if @options.wrapper_container_selector?

      @initFileUpload()
      @addFilesContainer()
      @bindEventHandlers()
      @redraw()
      @checkMaximum()

    initFileUpload: ->
      @options.field_name = @$input.attr('name')

      options =
        dataType: 'json'
        paramName: 'file'
        headers: {"X-Requested-With": "XMLHttpRequest"}
        dropZone: @config.dropZone || @$input
        sequentialUploads: true

      if @$input.attr('accept')
        @options.acceptFileTypes = options.acceptFileTypes = new RegExp("^#{@$input.attr('accept').split(",").join("|")}$", "i")

      @$input.fileupload(options)

    bindEventHandlers: ->
      @$input.bind 'fileuploadsend', (event, data) =>
        aborted = false
        data.files.forEach (file) =>
          if @options.accept? && !@options.acceptFileTypes.test(file.type)
            alert @config.invalidFormatMessage
            aborted = true
        if aborted
          return
        @$input.addClass 'uploading'
        @$wrapper.addClass 'uploading' if @$wrapper?
        @$form.addClass  'uploading'

        @$input.prop 'disabled', true
        if @config.disableWith
          @$submit.each (index,input) =>
            $input = $(input)
            $input.data 'old-val', $input.val() unless $input.data('old-val')?
          @$submit.val  @config.disableWith
          @$submit.prop 'disabled', true

        !@maximumReached()


      @$input.bind 'fileuploaddone', (event, data) =>
        @addFile(data.result)

      @$input.bind 'fileuploadfail', (event, data) =>
        @failAlert(data)

      @$input.bind 'fileuploadstart', (event) =>
        # important! changed on every file upload
        @$input = $(event.target)

      @$input.bind 'fileuploadalways', (event) =>
        @$input.removeClass 'uploading'
        @$wrapper.removeClass 'uploading' if @$wrapper?
        @$form.removeClass  'uploading'

        @checkMaximum()
        if @config.disableWith
          @$submit.each (index,input) =>
            $input = $(input)
            $input.val  $input.data('old-val')
          @$submit.prop 'disabled', false

      @$input.bind 'fileuploadprogressall', (e, data) =>
        progress = parseInt(data.loaded / data.total * 100, 10)
        if @config.disableWith && @config.indicateProgress
          @$submit.val "[#{progress}%] #{@config.disableWith}"


    addFile: (file) ->
      if !@options.accept || $.inArray(file.format, @options.accept) != -1  || $.inArray(file.resource_type, @options.accept) != -1
        @files.push file
        @redraw()
        @checkMaximum()
        @$input.trigger 'attachinary:fileadded', [file]
      else
        alert @config.invalidFormatMessage

    failAlert: (data) ->
      alert @config.unknownErrorMessage


    removeFile: (fileIdToRemove) ->
      _files = []
      removedFile = null
      for file in @files
        if file.public_id == fileIdToRemove
          removedFile = file
        else
          _files.push file
      @files = _files
      @redraw()
      @checkMaximum()
      @$input.trigger 'attachinary:fileremoved', [removedFile]

    checkMaximum: ->
      if @maximumReached()
        @$wrapper.addClass 'disabled' if @$wrapper?
        @$input.prop('disabled', true)
      else
        @$wrapper.removeClass 'disabled' if @$wrapper?
        @$input.prop('disabled', false)

    maximumReached: ->
      @options.maximum && @files.length >= @options.maximum

    addFilesContainer: ->
      if @options.files_container_selector? and $(@options.files_container_selector).length > 0
        @$filesContainer = $(@options.files_container_selector)
      else
        @$filesContainer = $('<div class="attachinary_container">')
        @$input.after @$filesContainer

    redraw: ->
      @$filesContainer.empty()

      if @files.length > 0
        @$filesContainer.append @makeHiddenField(JSON.stringify(@files))

        @$filesContainer.append @config.render(@files)
        @$filesContainer.find('[data-remove]').on 'click', (event) =>
          event.preventDefault()
          @removeFile $(event.target).data('remove')

        @$filesContainer.show()
      else
        @$filesContainer.append @makeHiddenField(null)
        @$filesContainer.hide()

    makeHiddenField: (value) ->
      $input = $('<input type="hidden">')
      $input.attr 'name', @options.field_name
      $input.val value
      $input
)(jQuery)
