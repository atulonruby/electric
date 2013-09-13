sort_pictures = function(pics){
  this.pics = pics;
  this.slider = $('.pic_slider');
  this.li_count = Math.round(this.pics.length/3);
  this.arr = [];
  
  //lame
  this.li_1 = $('<li>');
  this.li_2 = $('<li>');
  
  
  this.li_1.append($('<img>',{src:this.pics[0].image.thumb.url}));
  this.li_1.append($('<img>',{src:this.pics[1].image.thumb.url}));
  this.li_1.append($('<img>',{src:this.pics[2].image.thumb.url}));
  this.li_2.append($('<img>',{src:this.pics[3].image.thumb.url}));
  this.li_2.append($('<img>',{src:this.pics[4].image.thumb.url}));

  
  
  
  
};
