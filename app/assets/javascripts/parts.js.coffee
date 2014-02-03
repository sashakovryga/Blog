# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  markdownSettings = {
    previewParserPath: '/markdown/preview'
    onShiftEnter:	{keepDefault:false, openWith:'\n\n'}
    markupSet: [
      {
        name:'First Level Heading', key:'1',
        placeHolder:'Your title here...',
        closeWith: (markItUp) -> markdownTitle(markItUp, '=')
      },
      {
        name:'Second Level Heading', key:'2', placeHolder:'Your title here...',
        closeWith: (markItUp) -> markdownTitle(markItUp, '-')
      },
      {name:'Heading 3', key:'3', openWith:'### ', placeHolder:'Your title here...' }
      {name:'Heading 4', key:'4', openWith:'#### ', placeHolder:'Your title here...' }
      {name:'Heading 5', key:'5', openWith:'##### ', placeHolder:'Your title here...' }
      {name:'Heading 6', key:'6', openWith:'###### ', placeHolder:'Your title here...' }
      {name:'Paragragh', key:'G', openWith:' ', placeHolder:'Your title here...' }
      {separator:'---------------' }
      {name:'Bold', key:'B', openWith:'>'}
      {name:'Italic', key:'I', openWith:'_', closeWith:'_'}
      {name:'Stroke through', key:'S', openWith:'-', closeWith:'-'}
      {separator:'---------------' }
      {name:'Bulleted List', openWith:'- ' }
      {name:'Numeric List', openWith: (markItUp) -> markItUp.line+'. ' }
      {name:'List',openWith:'- ' }
      {separator:'---------------' }
     
       {name:'Picture', key:'P',replaceWith:'![[![Alternative text]!]]([![Url:!:http://]!] "[![Title]!]")'},
      {
        name:'Link', key:'L', openWith:'[',
        closeWith:']([![Url:!:http://]!] "[![Title]!]")',
        placeHolder:'Your text to link here...'
      },
      {separator:'---------------'}
      {name:'Quotes', openWith:'> '}
      {name:'Code Block / Code', openWith:'(!(\t|!|`)!)', closeWith:'(!(`)!)'}
      {separator:'---------------'}
      {name:'Preview', call:'preview', className:"preview"}
    ]
  }

  markdownTitle = (markItUp, char) ->
    heading = '';
    n = $.trim(markItUp.selection||markItUp.placeHolder).length;
    for i in [0..n]
      heading += char
    '\n'+heading

  $('#part_body').markItUp(markdownSettings)
  

 InlineUpload =
  dialog: null
  options:
    form_class: "inline_upload_form" # class формы
    action: "/part/update" # урл на который будет отправлен POST c загруженым файлом
    iframe: "inline_upload_iframe" # имя iframe

  display: (hash) -> # метод, который принимает на себя клик по кнопке в markItUp
    self = this
    @dialog = $(document).find(".inline_upload_container")
    unless @dialog.size() # нашего скрытого div нету DOM'a, создаем
      # создаем форму с iframe внутри невидимого div и прикрепляем его к body
      @dialog = $(["<div style=\"opacity:0;position:absolute;\" class=\"inline_upload_container\"><form class=\"", @options.form_class, "\" action=\"", @options.action, "\" target=\"", @options.iframe, "\" method=\"post\" enctype=\"multipart/form-data\">", "<input name=\"form[inlineUploadFile]\" type=\"file\" /></form>" + "<iframe id=\"", @options.iframe, "\" name=\"", @options.iframe, "\" class=\"", @options.iframe, "\" src=\"about:blank\" width=\"0\" height=\"0\"></iframe></div>"].join(""))
      @dialog.appendTo document.body
    
    # делаем клик по input[type=file] в скрытом div'e
    # чтобы показать системный диалог выборки файла
    $("input[name='form[inlineUploadFile]']").focus() # хак для хрома и прочих
    $("input[name='form[inlineUploadFile]']").trigger "click"
    
    # после того, как файл был выбран, отправляем нашу скрытую форму на сервер
    $("input[name='form[inlineUploadFile]']").live "change", ->
      # если файл небыл выбран, ничего страшного не произойдет
      $("." + self.options.form_class).submit()  unless $(this).val() is ""

    
    # ответ будет отдан в скрытый iframe
    $("." + @options.iframe).bind "load", ->
      responseJSONStr = $(this).contents().find("body").html()
      unless responseJSONStr is "" # сервер вернул нам ответ, будем его парсить
        response = $.parseJSON(responseJSONStr)
        if response.status is "success" # если все хорошо
          block = ["<img src=\"" + response.src + "\" width=\"" + response.width + "\" height=\"" + response.height + "\" alt=\"\" class=\"\"/>"]
          $.markItUp replaceWith: block.join("") # добавляем тег img в текст
        else
          alert response.msg # сообщение об ошибке
        self.cleanUp() # cleanUp() убирает скрытый div с формой и iframe из DOM


  cleanUp: ->
    $("input[name='form[inlineUploadFile]']").die "change"
    @dialog.remove()