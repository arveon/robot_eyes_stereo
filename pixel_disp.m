function y = pixel_disp(src_segment, search_window)
%use this for getting src_segment (mb use 10 instead of win_size)
%     src = im_f(x-(win_size/2):x+win_size/2,
%     y-(win_size/2):y+win_size/2,:);

    [sw_width, sw_height] = size(search_window);
    [sg_width, sg_height] = size(src_segment);
    dif=zeros(sw_width,sw_height);
    dif(:,:)=-1;
    
    lowest=100000;
    lowest_x = -1;
    lowest_y = -1;
    for x = 1+sg_width/2 : sw_width-sg_width/2
       for y = 1+sg_height/2 : sw_height-sg_height/2
           x=round(x);
           y=round(y);
           test=search_window(x-sg_width/2:x-1+sg_width/2, y-sg_height/2:y-1+sg_height/2);
           dif(x,y)=support_cmp(src_segment, test,sg_width);
           if dif(x,y) < lowest
               lowest = dif(x,y);
               lowest_x = x;
               lowest_y = y;
           end
           
       end
    end
    y=[lowest lowest_x lowest_y];
    