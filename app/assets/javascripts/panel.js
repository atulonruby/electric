panel = function(ele){
  if (ele !== undefined){
    var ele = ele;
    $.each(ele.children('.news'),function(key,value){
        var panel = $(this).children('.panel_contact');
        $(this).children('.elec').click(function(event){
           if (panel.hasClass('show')){
                 panel.slideUp();
                 panel.removeClass('show');
            }
            else{
                 panel.addClass('show')
                 panel.slideDown();
            }
            event.stopPropagation()
        });
    });
  
}
}
