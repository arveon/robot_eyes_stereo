function x = pixel_disp(src_segment, search_window)
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
    dif=zeros(sw_height,sw_width);
    dif(:,:)=-1;
    
    %set of variables to store most similar pixel similarity score and
    %distance
    lowest=100000;
    lowest_x = -1;
    lowest_y = -1;
    
    half_sg_height=floor(sg_height/2);
    half_sg_width=floor(sg_width/2);
    
    %loop through all possible pixels drawing a "frame" around each pixel.
    %frame size is equal to segment size
    for y = 1+half_sg_height : sw_width-half_sg_height
       for x = 1+half_sg_width : sw_height-half_sg_width
           %crop a frame from window that is being searched and run the
           %similarity function on them. store the resulting value at the
           %position of the explored pixel
           test=search_window(y-half_sg_height:y-1+half_sg_height, x-half_sg_width:x-1+half_sg_width);
           dif(y,x)=support_cmp(src_segment, test,sg_width);
           
           %check if current position is new lowest and store it alongside
           %its coordinate if it is
           if dif(y,x) < lowest
               lowest = dif(y,x);
               lowest_y = y;
               lowest_x = x;
           end
       end
    end
    %return all values as array
    x=lowest_x;
    