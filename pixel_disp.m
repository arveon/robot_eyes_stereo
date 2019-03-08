function y = pixel_disp(src_segment, search_window)
%use this for getting src_segment (mb use 10 instead of win_size)
%     src = im_f(x-(win_size/2):x+win_size/2,
%     y-(win_size/2):y+win_size/2,:);

    %get dimensions of both windows
    [sw_width, sw_height] = size(search_window);
    [sg_width, sg_height] = size(src_segment);
    
    %prepare matrix that will represent similarity of all search window
    %pixels to src_segment pixels
    %-1 is value set for unvisited pixels (the ones that can't be scanned
    %without padding)
    dif=zeros(sw_width,sw_height);
    dif(:,:)=-1;
    
    %set of variables to store most similar pixel similarity score and
    %distance
    lowest=100000;
    lowest_x = -1;
    lowest_y = -1;
    
    %loop through all possible pixels drawing a "frame" around each pixel.
    %frame size is equal to segment size
    for x = 1+sg_width/2 : sw_width-sg_width/2
       for y = 1+sg_height/2 : sw_height-sg_height/2
           %make sure coordinates are whole numbers
           x=round(x);
           y=round(y);
           %crop a frame from window that is being searched and run the
           %similarity function on them. store the resulting value at the
           %position of the explored pixel
           test=search_window(round(x-sg_width/2):round(x-1+sg_width/2), round(y-sg_height/2):round(y-1+sg_height/2));
           dif(x,y)=support_cmp(src_segment, test,sg_width);
           
           %check if current position is new lowest and store it alongside
           %its coordinate if it is
           if dif(x,y) < lowest
               lowest = dif(x,y);
               lowest_x = x;
               lowest_y = y;
           end
           
       end
    end
    
    %return all values as array
    y=lowest_x;
    