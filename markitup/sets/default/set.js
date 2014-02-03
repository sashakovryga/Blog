mySettings = {
 previewParserPath: '/markdown/preview'
  markupSet: [		
	  {name:'Bold', key:'B', openWith:'[b]', closeWith:'[/b]'}, 
	  {name:'Italic', key:'I', openWith:'[i]', closeWith:'[/i]'}, 
	  {name:'Underline', key:'U', openWith:'[u]', closeWith:'[/u]'}, 
	  {separator:'---------------' },
	  {name:'Link to Photo Image', key:'P', replaceWith:'[img][![Url]!][/img]'}, 
	  // Added by CF Mitrah
	  {name:'Upload Photo', key:'M',beforeInsert: function(markItUp) { InlineUpload.display(markItUp,true) } 	},
	  {name:'Browse', key:'F',beforeInsert: function(markItUp) { InlineUpload.display(markItUp,false) } 	},
	  // Added by CF Mitrah
	  {name:'Link', key:'L', openWith:'[url=[![Url]!]]', closeWith:'[/url]', placeHolder:'Your text to link here...'},
	  {separator:'---------------' },
	  {name:'Size', key:'S', openWith:'[size=[![Text size]!]]', closeWith:'[/size]', 
	  dropMenu :[
		  {name:'Big', openWith:'[size=200]', closeWith:'[/size]' }, 
		  {name:'Normal', openWith:'[size=100]', closeWith:'[/size]' }, 
		  {name:'Small', openWith:'[size=50]', closeWith:'[/size]' }
	  ]}, 
	  {separator:'---------------' },
	  {name:'Bulleted list', openWith:'[list]\n', closeWith:'\n[/list]'}, 
	  {name:'Numeric list', openWith:'[list=[![Starting number]!]]\n', closeWith:'\n[/list]'}, 
	  {name:'List item', openWith:'[*] '}, 
	  {separator:'---------------' },
	  {name:'Quotes', openWith:'[quote]', closeWith:'[/quote]'}, 
	  {name:'Code', openWith:'[code]', closeWith:'[/code]'}, 
	  {separator:'---------------' },
	  {name:'Clean', className:"clean", replaceWith:function(h) { return h.selection.replace(/\[(.*?)\]/g, "") } },
	
		
	      {name:'Preview', call:'preview', className:"preview"}
   ]
}
markdownTitle = (markItUp, char) ->
    heading = '';
    n = $.trim(markItUp.selection||markItUp.placeHolder).length;
    for i in [0..n]
      heading += char
    '\n'+heading
$('#part_body').markItUp(markupSet)